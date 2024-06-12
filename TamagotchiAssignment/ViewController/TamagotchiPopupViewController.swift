//
//  TamagotchiPopupViewController.swift
//  TamagotchiAssignment
//
//  Created by Minjae Kim on 6/8/24.
//

import UIKit
import SnapKit

final class TamagotchiPopupViewController: UIViewController, ConfigureViewProtocol {

    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.opacity = 0.5
        return view
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = TamagotchiUsed.Color.tamagotchiBackgroundColor
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    private let tamagotchiImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "noImage")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let nameBackgroundView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = TamagotchiUsed.Color.tamagotchiBorderColor.cgColor
        view.layer.cornerRadius = 5
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "준비중이에요"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = TamagotchiUsed.Color.tamagotchiBorderColor
        
        return label
    }()
    
    private let divider: UIView = {
        let view = UIView()
        view.backgroundColor = TamagotchiUsed.Color.tamagotchiBorderColor
        return view
    }()
    
    private let introduceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.textColor = TamagotchiUsed.Color.tamagotchiBorderColor
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.configuration = .plain()
        button.backgroundColor = TamagotchiUsed.Color.tamagotchiButtonBackgroundColor
        button.configureButtonTitleColorChangeOnByState(title: "취소")
        return button
    }()
    
    private let startButton: UIButton = {
        let button = UIButton()
        button.configuration = .plain()
        return button
    }()
    
    private let buttonDivider: UIView = {
        let view = UIView()
        view.backgroundColor = TamagotchiUsed.Color.tamagotchilightBackgroundColor
        return view
    }()
    
    private let userDefaultsHelper = UserDefaultsHelper.shared
    
    private var rightButtonTitle: String {
        guard let tamagotchiSelectType else { return "" }
        
        switch tamagotchiSelectType {
        case .select:
            return "선택하기"
        case .change:
            return "변경하기"
        }
    }
    
    var tamagotchi: Tamagotchi?
    var tamagotchiSelectType: TamagotchiUsed.TamagotchiSelectType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureContent()
    }
    
    func configureHierarchy() {
        view.addSubview(backgroundView)
        view.addSubview(contentView)
        contentView.addSubview(tamagotchiImageView)
        
        nameBackgroundView.addSubview(nameLabel)
        contentView.addSubview(nameBackgroundView)
        contentView.addSubview(divider)
        contentView.addSubview(introduceLabel)
        contentView.addSubview(cancelButton)
        contentView.addSubview(startButton)
        contentView.addSubview(buttonDivider)
    }
    
    func configureLayout() {
        
        backgroundView.snp.makeConstraints { make in
            make.horizontalEdges.verticalEdges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.centerY.equalTo(view.snp.centerY)
            make.height.equalTo(view.snp.height).multipliedBy(0.5)
        }
        
        tamagotchiImageView.snp.makeConstraints { make in
            make.top.equalTo(50)
            make.centerX.equalTo(contentView.snp.centerX)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.5)
            make.height.equalTo(contentView.snp.height).multipliedBy(0.3)
        }
        
        nameBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(tamagotchiImageView.snp.bottom).offset(8)
            make.centerX.equalTo(tamagotchiImageView.snp.centerX)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.horizontalEdges.verticalEdges.equalToSuperview().inset(6)
            make.height.equalTo(20)
        }
        
        divider.snp.makeConstraints { make in
            make.top.equalTo(nameBackgroundView.snp.bottom).offset(24)
            make.centerX.equalTo(contentView.snp.centerX)
            make.width.equalTo(contentView.snp.height).multipliedBy(0.5)
            make.height.equalTo(1)
        }
        
        introduceLabel.snp.makeConstraints { make in
            make.top.equalTo(divider.snp.bottom).offset(24)
            make.centerX.equalTo(contentView.snp.centerX)
            make.width.equalTo(contentView.snp.height).multipliedBy(0.5)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(introduceLabel.snp.bottom).offset(24)
            make.leading.equalTo(contentView.snp.leading)
            make.bottom.equalTo(contentView.snp.bottom)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.5)
            make.height.equalTo(40)
        }
        
        startButton.snp.makeConstraints { make in
            make.top.equalTo(cancelButton.snp.top)
            make.trailing.equalTo(contentView.snp.trailing)
            make.bottom.equalTo(contentView.snp.bottom)
            make.width.equalTo(cancelButton.snp.width)
            make.height.equalTo(cancelButton.snp.height)
        }
        
        buttonDivider.snp.makeConstraints { make in
            make.top.equalTo(introduceLabel.snp.bottom).offset(23)
            make.bottom.equalTo(cancelButton.snp.top)
            make.width.equalTo(contentView.snp.width)
        }
    }
    
    func configureContent() {
        let backgroundViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundViewTapped))
        
        backgroundView.isUserInteractionEnabled = true
        backgroundView.addGestureRecognizer(backgroundViewTapGesture)
        
        guard let tamagotchi, tamagotchi.isAvailable else { return }
        
        tamagotchiImageView.image = UIImage(named: String(tamagotchi.id) + "-6")
        nameLabel.text = tamagotchi.name
        introduceLabel.text = tamagotchi.introduce
        
        cancelButton.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
        
        startButton.configurationUpdateHandler = { [weak self] btn in
            guard let self else { return }
            
            switch btn.state {
            case .highlighted:
                btn.configuration?.attributedTitle = AttributedString(
                    NSAttributedString(string: rightButtonTitle, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .bold), NSAttributedString.Key.foregroundColor: TamagotchiUsed.Color.tamagotchilightBackgroundColor]))
            default:
                btn.configuration?.attributedTitle = AttributedString(
                    NSAttributedString(string: rightButtonTitle, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .bold), NSAttributedString.Key.foregroundColor: TamagotchiUsed.Color.tamagotchiBorderColor]))
            }
        }
        
        startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
    }
    
    @objc
    private func backgroundViewTapped() {
        dismiss(animated: true)
    }
    
    @objc
    private func cancelButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc
    private func startButtonClicked() {
        dismiss(animated: true)
        
        guard let tamagotchi else { return }
        userDefaultsHelper.setSelectTamagochi(tamagotchi)
        userDefaultsHelper.setIsNotFirstMeetWithTamagochi(true)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: TamagotchiUsed.NotificationCenterName.selectButton), object: nil)
    }
}
