//
//  TamagotchiViewController.swift
//  TamagotchiAssignment
//
//  Created by Minjae Kim on 6/9/24.
//

import UIKit
import SnapKit

final class TamagotchiViewController: UIViewController, ConfigureViewProtocol {

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.keyboardDismissMode = .interactive
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let randomBubbleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bubble")
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let randomBubbleLabel: UILabel = {
        let label = UILabel()
        label.text = "토할거가타요ㅠㅁㅠ"
        label.font = TamagotchiUsed.Font.bold13
        label.textColor = TamagotchiUsed.Color.tamagotchiBorderColor
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let tamagotchiView = ReusableTamagotchiView()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "LV1 ∙ 밥알 0개 ∙ 물방울 0개"
        label.font = TamagotchiUsed.Font.bold14
        label.textColor = TamagotchiUsed.Color.tamagotchiBorderColor
        label.textAlignment = .center
        return label
    }()
    
    private let eatTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.attributedPlaceholder = NSAttributedString(
            string: "밥주세용", attributes: [NSAttributedString.Key.font: TamagotchiUsed.Font.bold14])
        textField.font = TamagotchiUsed.Font.bold14
        textField.textAlignment = .center
        textField.textColor = TamagotchiUsed.Color.tamagotchiBorderColor
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private let eatUnderBar: UIView = {
        let view = UIView()
        view.backgroundColor = TamagotchiUsed.Color.tamagotchiBorderColor
        return view
    }()
    
    private let eatButton: UIButton = {
        let button = UIButton()
        button.configuration = .plain()
        button.configuration?.baseBackgroundColor = UIColor.clear
        button.layer.borderColor = TamagotchiUsed.Color.tamagotchiBorderColor.cgColor
        button.layer.borderWidth = 1.5
        button.layer.cornerRadius = 5
        button.configuration?.image = UIImage(systemName: "leaf.circle")
        button.configuration?.preferredSymbolConfigurationForImage = .init(pointSize: 14)
        button.configuration?.imagePadding = 4
        button.configuration?.contentInsets = .init(top: 0, leading: -16, bottom: 0, trailing: -16)
        button.configureButtonTitleColorChangeOnByState(title: "밥먹기")
        return button
    }()
    
    private let drinkTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.attributedPlaceholder = NSAttributedString(
            string: "물주세용", attributes: [NSAttributedString.Key.font: TamagotchiUsed.Font.bold14])
        textField.font = TamagotchiUsed.Font.bold14
        textField.textColor = TamagotchiUsed.Color.tamagotchiBorderColor
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private let drinkUnderBar: UIView = {
        let view = UIView()
        view.backgroundColor = TamagotchiUsed.Color.tamagotchiBorderColor
        return view
    }()
    
    private let drinkButton: UIButton = {
        let button = UIButton(type: .system)
        button.configuration = .plain()
        button.configuration?.baseBackgroundColor = UIColor.clear
        button.layer.borderColor = TamagotchiUsed.Color.tamagotchiBorderColor.cgColor
        button.layer.borderWidth = 1.5
        button.layer.cornerRadius = 5
        button.configuration?.image = UIImage(systemName: "leaf.circle")
        button.configuration?.preferredSymbolConfigurationForImage = .init(pointSize: 14)
        button.configuration?.imagePadding = 4
        button.configuration?.contentInsets = .init(top: 0, leading: -16, bottom: 0, trailing: -16)
        button.configureButtonTitleColorChangeOnByState(title: "물먹기")
        return button
    }()
    
    private var tamagotchi: Tamagotchi? {
        get {
            guard let tamagotchies = UserDefaultsManager.tamagotchies else { return nil }
            guard let id = UserDefaultsManager.selectedTamagotchiID else { return nil }
            
            for tamagotchi in tamagotchies {
                if id == tamagotchi.id {
                    return tamagotchi
                }
            }
            
            return nil
        }
        set {
            guard let newValue, var tamagotchies = UserDefaultsManager.tamagotchies else { return }
            for i in 0..<tamagotchies.count {
                if newValue.id == tamagotchies[i].id {
                    tamagotchies[i] = newValue
                }
            }
            UserDefaultsManager.tamagotchies = tamagotchies
            configureContent()
        }
    }
    
    private var randomBubble: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = TamagotchiUsed.Color.tamagotchiBackgroundColor
        configureNickname()
        configureNavigation()
        configureHierarchy()
        configureLayout()
        configureContent()
        
        configureNotificationCenter()
        configureTextField()
        confgureButtonAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNickname()
        configureContent()
    }
    
    private func configureNickname() {
        let nickname = UserDefaultsManager.nickname ?? "대장"
        navigationItem.title = nickname + "님의 다마고치"
        randomBubble = [
            "\(nickname) 오늘 깃허브 푸시 하셨어영?",
            "\(nickname) 오늘 과제 하셨어용?",
            "\(nickname) 콜렉션 뷰 어렵당 ㅠㅠ",
            "\(nickname) 토할거가타요ㅠㅁㅠ",
            "\(nickname) 목말라용 ~~~~~~",
            "\(nickname) 취업 언제 하냐고오오오",
            "\(nickname) 오토레이아웃 너무 어렵지 않나요???",
            "\(nickname) 님 저 너무 배가 고파욤 ㅠㅁㅠ"
        ]
    }
    
    private func configureNotificationCenter() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        scrollView.contentInset.bottom = keyboardFrame.size.height
    }
    
    @objc private func keyboardWillHide() {
        let contentInset = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
    }
    
    func configureNavigation() {
        navigationController?.configureTamagotchiStyle()
        navigationController?.navigationBar.tintColor = TamagotchiUsed.Color.tamagotchiBorderColor
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle"),
                                                 style: .plain, target: self, action: #selector(rightBarButtonItemClicked))
        
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc
    private func rightBarButtonItemClicked() {
        
        let settingViewController = SettingViewController()
        navigationController?.pushViewController(settingViewController, animated: true)
    }
    
    func configureHierarchy() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(tamagotchiView)
        contentView.addSubview(randomBubbleImageView)
        contentView.addSubview(randomBubbleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(eatTextField)
        contentView.addSubview(eatUnderBar)
        contentView.addSubview(eatButton)
        contentView.addSubview(drinkTextField)
        contentView.addSubview(drinkUnderBar)
        contentView.addSubview(drinkButton)
    }
    
    func configureLayout() {
        
        scrollView.snp.makeConstraints { make in
            make.horizontalEdges.verticalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
            make.height.equalTo(scrollView.frameLayoutGuide)
        }
        
        tamagotchiView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalToSuperview().multipliedBy(0.25)
            make.centerX.equalToSuperview()
        }
        
        randomBubbleImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.centerX.equalTo(tamagotchiView)
            make.width.equalTo(tamagotchiView.snp.width).multipliedBy(1.2)
            make.height.equalToSuperview().multipliedBy(0.2)
            make.bottom.equalTo(tamagotchiView.snp.top).offset(-4)
        }
        
        randomBubbleLabel.snp.makeConstraints { make in
            make.top.equalTo(randomBubbleImageView.snp.top).offset(8)
            make.centerX.equalTo(randomBubbleImageView.snp.centerX)
            make.horizontalEdges.equalTo(randomBubbleImageView.snp.horizontalEdges).inset(8)
            make.bottom.equalTo(randomBubbleImageView.snp.bottom).offset(-20)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(tamagotchiView.snp.bottom).offset(16)
            make.centerX.equalTo(tamagotchiView.snp.centerX)
        }
        
        eatButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(32)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).offset(-80)
            make.height.equalTo(35)
            make.width.equalTo(scrollView.snp.width).multipliedBy(0.18)
        }
        
        eatTextField.snp.makeConstraints { make in
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(80)
            make.centerY.equalTo(eatButton.snp.centerY)
            make.trailing.equalTo(eatButton.snp.leading).offset(-12)
        }
        
        eatUnderBar.snp.makeConstraints { make in
            make.leading.equalTo(eatTextField.snp.leading)
            make.trailing.equalTo(eatTextField.snp.trailing)
            make.height.equalTo(1.5)
            make.bottom.equalTo(eatButton.snp.bottom)
        }
        
        drinkButton.snp.makeConstraints { make in
            make.top.equalTo(eatButton.snp.bottom).offset(12)
            make.trailing.equalTo(contentView).offset(-80)
            make.height.equalTo(35)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.18)
        }
        
        drinkTextField.snp.makeConstraints { make in
            make.leading.equalTo(contentView).offset(80)
            make.centerY.equalTo(drinkButton.snp.centerY)
            make.trailing.equalTo(drinkButton.snp.leading).offset(-12)
        }
        
        drinkUnderBar.snp.makeConstraints { make in
            make.leading.equalTo(drinkTextField.snp.leading)
            make.trailing.equalTo(drinkTextField.snp.trailing)
            make.height.equalTo(1.5)
            make.bottom.equalTo(drinkButton.snp.bottom)
        }
    }
    
    func configureContent() {
        guard let tamagotchi else { return }
        
        randomBubbleLabel.text = randomBubble.randomElement()

        tamagotchiView.configureNameLabelFont(TamagotchiUsed.Font.bold14)
        tamagotchiView.configureContent(tamagotchi, usedTo: .main)
        
        descriptionLabel.text = "LV\(tamagotchi.level) ∙ 밥알 \(tamagotchi.rice)개 ∙ 물방울 \(tamagotchi.water)개"
    }
    
    private func confgureButtonAction() {
        eatButton.addTarget(self, action: #selector(eatButtonClicked), for: .touchUpInside)
        drinkButton.addTarget(self, action: #selector(drinkButtonClicked), for: .touchUpInside)
    }
    
    @objc
    private func eatButtonClicked() {
        guard let tamagotchi, let text = eatTextField.text else { return }
        
        if text.count == 0 {
            self.tamagotchi = tamagotchi.addRice(1)
            eatTextField.text = nil
        }
        
        if let eatCount = Int(text), eatCount < 100 {
            self.tamagotchi = tamagotchi.addRice(eatCount)
            eatTextField.text = nil
        }
    }
    
    @objc
    private func drinkButtonClicked() {
        guard let tamagotchi, let text = drinkTextField.text else { return }
        
        if text.count == 0 {
            self.tamagotchi = tamagotchi.addWater(1)
            drinkTextField.text = nil
        }
        
        if let drinkCount = Int(text), drinkCount < 50 {
            self.tamagotchi = tamagotchi.addWater(drinkCount)
            drinkTextField.text = nil
        }
    }
}

extension TamagotchiViewController: UITextFieldDelegate {
    
    private func configureTextField() {
        eatTextField.delegate = self
        drinkTextField.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 44.0))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let DoneButton = UIBarButtonItem(barButtonSystemItem: .done, target: target, action: #selector(doneButtonClicked))
        let titleItem = UIBarButtonItem(title: textField.placeholder, style: .plain, target: nil, action: nil)
        titleItem.tintColor = UIColor.systemGray
        toolBar.setItems([flexibleSpace, titleItem, flexibleSpace, DoneButton], animated: false)
        textField.inputAccessoryView = toolBar
    }
    
    @objc
    private func doneButtonClicked() {
        if eatTextField.isFirstResponder {
            eatTextField.resignFirstResponder()
        }
        
        if drinkTextField.isFirstResponder {
            drinkTextField.resignFirstResponder()
        }
    }
}
