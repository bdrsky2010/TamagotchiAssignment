//
//  ConfigureViewProtocol.swift
//  TamagotchiAssignment
//
//  Created by Minjae Kim on 6/7/24.
//

import Foundation

@objc
protocol ConfigureViewProtocol {
    @objc optional func configureNavigation()
    @objc optional func configureHierarchy()
    @objc optional func configureLayout()
    @objc optional func configureUI()
    @objc optional func configureContent()
}
