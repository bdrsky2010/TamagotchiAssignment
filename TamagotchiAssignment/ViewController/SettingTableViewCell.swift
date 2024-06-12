//
//  SettingTableViewCell.swift
//  TamagotchiAssignment
//
//  Created by Minjae Kim on 6/9/24.
//

import UIKit
import SnapKit

class SettingTableViewCell: UITableViewCell, ConfigureViewProtocol {
    
    private let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "pencil")
        imageView.tintColor = TamagotchiUsed.Color.tamagotchiBorderColor
        imageView.preferredSymbolConfiguration = .init(pointSize: 14)
        return imageView
    }()
    
    private let mainTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "설정하기"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "고래밥"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = TamagotchiUsed.Color.tamagotchiBorderColor
        return label
    }()
    
    private let pushImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.forward")
        imageView.preferredSymbolConfiguration = .init(pointSize: 14)
        imageView.tintColor = TamagotchiUsed.Color.tamagotchilightBackgroundColor
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = TamagotchiUsed.Color.tamagotchiBackgroundColor
        
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        contentView.addSubview(cellView)
        cellView.addSubview(mainImageView)
        cellView.addSubview(mainTitleLabel)
        cellView.addSubview(subTitleLabel)
        cellView.addSubview(pushImageView)
    }
    
    func configureLayout() {
        cellView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        mainImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        mainTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(mainImageView.snp.trailing).offset(16)
            make.centerY.equalTo(mainImageView)
        }
        
        pushImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.trailing.equalTo(pushImageView).offset(-16)
            make.centerY.equalTo(pushImageView)
        }
    }
    
    public func configureCellContent(_ setting: Setting) {
        mainImageView.image = UIImage(systemName: setting.mainImage)
        mainTitleLabel.text = setting.mainTitle
        subTitleLabel.text = setting.subTitle
    }
}
