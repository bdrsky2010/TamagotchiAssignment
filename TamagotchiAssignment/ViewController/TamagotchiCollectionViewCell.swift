//
//  TamagotchiCollectionViewCell.swift
//  TamagotchiAssignment
//
//  Created by Minjae Kim on 6/7/24.
//

import UIKit
import SnapKit

final class TamagotchiCollectionViewCell: UICollectionViewCell, ConfigureViewProtocol {
    
    private let tamagotchiView = ReusableTamagotchiView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        contentView.addSubview(tamagotchiView)
    }
    
    func configureLayout() {
        
        tamagotchiView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureContent(_ tamagotchi: Tamagotchi) {
        if tamagotchi.isAvailable {
            tamagotchiView.configureContent(tamagotchi, usedTo: .etc)
        }
        tamagotchiView.configureNameLabelFont(TamagotchiUsed.Font.bold11)
    }
}
