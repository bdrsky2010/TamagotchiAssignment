//
//  TamagotchiCollectionViewCell.swift
//  TamagotchiAssignment
//
//  Created by Minjae Kim on 6/7/24.
//

import UIKit
import SnapKit

final class TamagotchiCollectionViewCell: UICollectionViewCell, ConfigureViewProtocol {
    
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
        label.font = .systemFont(ofSize: 11, weight: .bold)
        label.textColor = TamagotchiUsed.Color.tamagotchiBorderColor
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
    
    func configureContent(_ tamagotchi: Tamagotchi) {
        guard tamagotchi.isAvailable else { return }
        
        tamagotchiImageView.image = UIImage(named: String(tamagotchi.id) + "-6")
        nameLabel.text = tamagotchi.name
    }
}
