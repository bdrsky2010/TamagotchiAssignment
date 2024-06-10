//
//  UIButton+.swift
//  TamagotchiAssignment
//
//  Created by Minjae Kim on 6/11/24.
//

import UIKit

extension UIButton {
    func configureButtonTitleColorChangeOnByState(title: String) {
        self.configurationUpdateHandler = { btn in
            switch btn.state {
            case .highlighted:
                btn.configuration?.attributedTitle = AttributedString(
                    NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .bold), NSAttributedString.Key.foregroundColor: UIColor.tamagotchilightBackgroundColor]))
            default:
                btn.configuration?.attributedTitle = AttributedString(
                    NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .bold), NSAttributedString.Key.foregroundColor: UIColor.tamagotchiBorderColor]))
            }
        }
    }
}
