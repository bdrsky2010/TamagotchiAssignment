//
//  ReusableTamagotchiView.swift
//  TamagotchiAssignment
//
//  Created by Minjae Kim on 6/12/24.
//

import UIKit
import SnapKit

class ReusableTamagotchiView: UIView, ConfigureViewProtocol {
    
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
        label.textColor = TamagotchiUsed.Color.tamagotchiBorderColor
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
        addSubview(tamagotchiImageView)
        addSubview(nameBackgroundView)
        nameBackgroundView.addSubview(nameLabel)
    }
    
    func configureLayout() {
        nameBackgroundView.snp.makeConstraints { make in
            make.bottom.equalTo(snp.bottom)
            make.centerX.equalTo(snp.centerX)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.horizontalEdges.verticalEdges.equalToSuperview().inset(4)
        }
        
        tamagotchiImageView.snp.makeConstraints { make in
            make.top.equalTo(snp.top)
            make.horizontalEdges.equalTo(snp.horizontalEdges)
            make.bottom.equalTo(nameLabel.snp.top).offset(-8)
        }
    }
    
    func configureNameLabelFont(_ font: UIFont) {
        nameLabel.font = font
    }
    
    func configureContent(_ tamagotchi: Tamagotchi, usedTo: TamagotchiUsed.ReusableCellUsedTo) {
        tamagotchiImageView.image = UIImage(named: String(tamagotchi.id) + "-\(usedTo == .etc ? 6 : tamagotchi.level)")
        nameLabel.text = tamagotchi.name
    }
}
