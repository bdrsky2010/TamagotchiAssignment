//
//  TamagotchiCollectionViewCell.swift
//  TamagotchiAssignment
//
//  Created by Minjae Kim on 6/7/24.
//

import UIKit
import SnapKit

final class TamagotchiCollectionViewCell: UICollectionViewCell, ConfigureViewProtocol {
    
    static let identifier = "TamagotchiCollectionViewCell"
    
    public var tamagotchi: Tamagotchi?
    
    let tamagotchiImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "noImage")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let nameBackgroundView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 0.9
        view.layer.borderColor = UIColor(red: 77/255, green: 106/255, blue: 120/255, alpha: 1).cgColor
        view.layer.cornerRadius = 5
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "준비중이에요"
        label.font = .systemFont(ofSize: 11, weight: .bold)
        label.textColor = UIColor(red: 77/255, green: 106/255, blue: 120/255, alpha: 1)
        label.backgroundColor = .clear
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        contentView.addSubview(tamagotchiImageView)
        contentView.addSubview(nameBackgroundView)
        nameBackgroundView.addSubview(nameLabel)
    }
    
    func configureLayout() {
        
        nameBackgroundView.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.snp.bottom)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.horizontalEdges.verticalEdges.equalToSuperview().inset(4)
        }
        
        tamagotchiImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.horizontalEdges.equalTo(contentView.snp.horizontalEdges)
            make.bottom.equalTo(nameLabel.snp.top).offset(-2)
        }
    }
    
    func configureContent() {
        guard let tamagotchi, tamagotchi.isAvailable else { return }
        
        tamagotchiImageView.image = UIImage(named: tamagotchi.id + "-" + tamagotchi.stringLevel)
        nameLabel.text = tamagotchi.name
    }
}