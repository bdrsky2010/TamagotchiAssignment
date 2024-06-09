//
//  TamagotchiViewController.swift
//  TamagotchiAssignment
//
//  Created by Minjae Kim on 6/9/24.
//

import UIKit

class TamagotchiViewController: UIViewController, ConfigureViewProtocol {

    let randomBubbleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bubble")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let randomBubbleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .bold)
        label.textColor = UIColor.tamagotchiBorderColor
        label.textAlignment = .center
        return label
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
        
        return label
    }()
    
    private let userDefaultsHelper = UserDefaultsHelper.shared
    
    private var nickname: String {
        return userDefaultsHelper.getNickname()
    }
    
    private var tamagotchi: Tamagotchi {
        return userDefaultsHelper.getSelectTamagotchi()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.tamagotchiBackgroundColor
        
        configureNavigation()
        configureHierarchy()
        configureLayout()
        configureContent()
    }
    
    func configureNavigation() {
        navigationItem.title = nickname + "님의 다마고치"
        
        let rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.crop.circle"),
                                                 style: .plain, target: self, action: #selector(rightBarButtonItemClicked))
        
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc
    private func rightBarButtonItemClicked() {
        print(#function)
    }
    
    func configureHierarchy() {
        
    }
    
    func configureLayout() {
        
    }
    
    func configureContent() {
        
    }
}
