//
//  NicknameSettingViewController.swift
//  TamagotchiAssignment
//
//  Created by Minjae Kim on 6/9/24.
//

import UIKit
import SnapKit

final class NicknameSettingViewController: UIViewController, ConfigureViewProtocol {

    private let nameSettingTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "2~6자 사이로 입력해주세요", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold)])
        textField.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        textField.textColor = UIColor.tamagotchiBorderColor
        textField.borderStyle = .none
        return textField
    }()
    
    private let textFieldUnderBar: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.tamagotchiBorderColor
        return view
    }()
    
    private let removeTextButton: UIButton = {
        let button = UIButton()
        button.configuration = .plain()
        button.configuration?.image = UIImage(systemName: "xmark.circle.fill")
        button.tintColor = UIColor.tamagotchiBorderColor
        button.configuration?.preferredSymbolConfigurationForImage = .init(pointSize: 14)
        button.isHidden = true
        return button
    }()
    
    private let userDefaultsHelper = UserDefaultsHelper.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigation()
        configureHierarchy()
        configureLayout()
        configureTextField()
        configureRemoveButton()
        configureBackground()
    }
    
    func configureNavigation() {
        navigationItem.title = "\(userDefaultsHelper.getNickname())님 이름 정하기"
        
        let saveBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
        saveBarButtonItem.isEnabled = false
        
        navigationItem.rightBarButtonItem = saveBarButtonItem
    }
    
    @objc
    private func saveButtonClicked() {
        guard let nickname = nameSettingTextField.text else { return }
        userDefaultsHelper.setNickname(nickname)
        navigationController?.popViewController(animated: true)
    }
    
    func configureHierarchy() {
        view.addSubview(nameSettingTextField)
        view.addSubview(textFieldUnderBar)
        view.addSubview(removeTextButton)
    }
    
    func configureLayout() {
        nameSettingTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        textFieldUnderBar.snp.makeConstraints { make in
            make.top.equalTo(nameSettingTextField.snp.bottom).offset(8)
            make.height.equalTo(1)
            make.horizontalEdges.equalTo(nameSettingTextField)
        }
        
        removeTextButton.snp.makeConstraints { make in
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-12)
            make.centerY.equalTo(nameSettingTextField)
        }
    }
    
    private func configureTextField() {
        nameSettingTextField.delegate = self
    }
    
    private func configureRemoveButton() {
        removeTextButton.addTarget(self, action: #selector(removeButtonClicked), for: .touchUpInside)
    }
    
    @objc
    private func removeButtonClicked() {
        nameSettingTextField.text = nil
    }
    
    private func configureBackground() {
        view.backgroundColor = UIColor.tamagotchiBackgroundColor
        
        let backgroundTapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(backgroundTapGesture)
    }
    
    @objc
    private func backgroundTapped() {
        if nameSettingTextField.isFirstResponder {
            nameSettingTextField.resignFirstResponder()
        }
    }
}

extension NicknameSettingViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        if text.count > 0 {
            removeTextButton.isHidden = false
        } else {
            removeTextButton.isHidden = true
        }
        
        if text.count >= 2 && text.count <= 6 {
            navigationItem.rightBarButtonItem?.isEnabled = true
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
}
