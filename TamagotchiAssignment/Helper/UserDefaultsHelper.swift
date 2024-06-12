//
//  UserDefaultsHelper.swift
//  TamagotchiAssignment
//
//  Created by Minjae Kim on 6/8/24.
//

import Foundation

enum UserDefaultsManager {
    @UserDefaultWrapper(key: UserDefaultsKey.isFirstOpenedApp.rawValue, defaultValue: false)
    static var isFirstOpenedApp: Bool?
    
    @UserDefaultWrapper(key: UserDefaultsKey.selectedID.rawValue, defaultValue: nil)
    static var selectedTamagotchiID: Int?
    
    @UserDefaultWrapper(key: UserDefaultsKey.nickname.rawValue, defaultValue: "대장")
    static var nickname: String?
    
    @UserDefaultWrapper(key: UserDefaultsKey.tamagotchies.rawValue, defaultValue: UserDefaultsManager.defaultTamagotchies)
    static var tamagotchies: [Tamagotchi]?
    
    static let defaultTamagotchies: [Tamagotchi] = (0..<20).map { i in
        if i < 3 {
            let tamagotchiType = TamagotchiUsed.TamagotchiType.allCases[i]
            return Tamagotchi(isAvailable: true, id: tamagotchiType.id, name: tamagotchiType.name, introduce: tamagotchiType.introduce)
        }
        return Tamagotchi(isAvailable: false, id: -1, name: "준비중이에요", introduce: "")
    }
    
    static var tamagotchi: Tamagotchi? {
        guard let tamagotchies else { return nil }
        guard let selectedTamagotchiID else { return nil }
        
        for tamagotchi in tamagotchies {
            if tamagotchi.id == selectedTamagotchiID {
                return tamagotchi
            }
        }
        return nil
    }
    
    static func removeAllUserDefaultsData() {
        UserDefaultsKey.allCases.forEach {
            UserDefaults.standard.removeObject(forKey: $0.rawValue)
        }
    }
}
