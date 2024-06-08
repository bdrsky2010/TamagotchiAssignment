//
//  UserDefaultsHelper.swift
//  TamagotchiAssignment
//
//  Created by Minjae Kim on 6/8/24.
//

import Foundation

final class UserDefaultsHelper {
    static let shared = UserDefaultsHelper()
    
    private let isFirstMeetWithTamagotchiAppKey = "isFirstMeetWithTamagotchiAppKey"
    private let tamagotchiKey = "tamagotchiKey"
    
    private init() { }
    
    public func getIsFirstMeetWithTamagotchi() -> Bool {
        return UserDefaults.standard.bool(forKey: isFirstMeetWithTamagotchiAppKey)
    }
    
    public func setIsFirstMeetWithTamagochi(_ isFirst: Bool) {
        UserDefaults.standard.set(isFirst, forKey: isFirstMeetWithTamagotchiAppKey)
    }
    
    public func getTamagochi() -> [Tamagotchi] {
        if let data = UserDefaults.standard.object(forKey: tamagotchiKey) as? Data {
            
            let decoder = JSONDecoder()
            
            if let tamagotchies = try? decoder.decode([Tamagotchi].self, from: data) {
                return tamagotchies
            }
        }
        
        return (0..<20).map { i in
            if i < 3 {
                let tamagotchiType = TamagotchiType.allCases[i]
                return Tamagotchi(isAvailable: true, id: tamagotchiType.id, name: tamagotchiType.name, introduce: tamagotchiType.introduce)
            }
            return Tamagotchi(isAvailable: false, id: "", name: "", introduce: "")
        }
    }
    
    public func setTamagochi(_ tamagotchies: [Tamagotchi]) {
        
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(tamagotchies) {
            UserDefaults.standard.set(encoded, forKey: tamagotchiKey)
        } else {
            
        }
    }
}
