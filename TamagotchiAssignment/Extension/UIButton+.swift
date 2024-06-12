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
                btn.configuration?.baseForegroundColor = TamagotchiUsed.Color.tamagotchilightBackgroundColor
                btn.configuration?.attributedTitle = AttributedString(
                    NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: TamagotchiUsed.Font.bold13, NSAttributedString.Key.foregroundColor: TamagotchiUsed.Color.tamagotchilightBackgroundColor]))
            default:
                btn.configuration?.baseForegroundColor = TamagotchiUsed.Color.tamagotchiBorderColor
                btn.configuration?.attributedTitle = AttributedString(
                    NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: TamagotchiUsed.Font.bold13, NSAttributedString.Key.foregroundColor: TamagotchiUsed.Color.tamagotchiBorderColor]))
            }
        }
    }
}
