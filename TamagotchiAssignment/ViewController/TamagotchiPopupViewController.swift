//
//  TamagotchiPopupViewController.swift
//  TamagotchiAssignment
//
//  Created by Minjae Kim on 6/8/24.
//

import UIKit
import SnapKit

class TamagotchiPopupViewController: UIViewController, ConfigureViewProtocol {

    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.opacity = 0.5
        return view
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.tamagotchiBackgroundColor
        view.layer.cornerRadius = 10
        return view
    }()
    
    let tamagotchiImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "noImage")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let nameBackgroundView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.tamagotchiBorderColor.cgColor
        view.layer.cornerRadius = 5
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "준비중이에요"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = UIColor.tamagotchiBorderColor
        label.backgroundColor = .clear
        
        return label
    }()
    
    let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.tamagotchiBorderColor
        return view
    }()
    
    let introduceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.textColor = UIColor.tamagotchiBorderColor
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let startButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    public var tamagotchi: Tamagotchi?
    
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
        contentView.addSubview(dividerView)
        contentView.addSubview(introduceLabel)
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
        }
        
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(nameBackgroundView.snp.bottom).offset(24)
            make.centerX.equalTo(contentView.snp.centerX)
            make.width.equalTo(contentView.snp.height).multipliedBy(0.5)
            make.height.equalTo(1)
        }
        
        introduceLabel.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom).offset(24)
            make.centerX.equalTo(contentView.snp.centerX)
            make.width.equalTo(contentView.snp.height).multipliedBy(0.5)
        }
    }
    
    func configureContent() {
        let backgroundViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundViewTapped))
        
        backgroundView.isUserInteractionEnabled = true
        backgroundView.addGestureRecognizer(backgroundViewTapGesture)
        
        guard let tamagotchi, tamagotchi.isAvailable else { return }
        
        tamagotchiImageView.image = UIImage(named: tamagotchi.id + "-6")
        nameLabel.text = tamagotchi.name
        introduceLabel.text = tamagotchi.introduce
    }
    
    @objc
    private func backgroundViewTapped() {
        dismiss(animated: true)
    }
}
