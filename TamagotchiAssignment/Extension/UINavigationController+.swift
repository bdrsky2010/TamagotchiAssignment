//
//  UINavigationController+.swift
//  TamagotchiAssignment
//
//  Created by Minjae Kim on 6/10/24.
//

import UIKit

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
    
    func configureTamagotchiStyle() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .bold), NSAttributedString.Key.foregroundColor: TamagotchiUsed.Color.tamagotchiBorderColor]
        navigationBarAppearance.backgroundColor = TamagotchiUsed.Color.tamagotchiBackgroundColor

        self.navigationBar.standardAppearance = navigationBarAppearance
    }
}
