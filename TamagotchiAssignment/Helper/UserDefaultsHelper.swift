//
//  UserDefaultsHelper.swift
//  TamagotchiAssignment
//
//  Created by Minjae Kim on 6/8/24.
//

import Foundation

final class UserDefaultsHelper {
    static let shared = UserDefaultsHelper()
    
    private let isNotFirstMeetWithTamagotchiAppKey = "isNotFirstMeetWithTamagotchiAppKey"
    private let tamagotchiKey = "tamagotchiKey"
    private let selectTamagotchiKey = "selectTamagotchiKey"
    private let nicknameKey = "nicknameKey"
    private let tamagotchiTypeKey = "tamagotchiTypeKey"
    
    private init() { }
    
    public func getIsNotFirstMeetWithTamagotchi() -> Bool {
        return UserDefaults.standard.bool(forKey: isNotFirstMeetWithTamagotchiAppKey)
    }
    
    public func setIsNotFirstMeetWithTamagochi(_ isFirst: Bool) {
        UserDefaults.standard.set(isFirst, forKey: isNotFirstMeetWithTamagotchiAppKey)
    }
    
    public func getTamagotchies() -> [Tamagotchi] {
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
            return Tamagotchi(isAvailable: false, id: -1, name: "", introduce: "")
        }
    }
    
    private func setTamagotchies(_ tamagotchies: [Tamagotchi]) {
        
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(tamagotchies) {
            UserDefaults.standard.set(encoded, forKey: tamagotchiKey)
        } else {
            
        }
    }
    
    public func getSelectTamagotchi() -> Tamagotchi? {
        let id = UserDefaults.standard.integer(forKey: selectTamagotchiKey)
        let tamagotchies = getTamagotchies()
        
        for i in 0..<tamagotchies.count {
            if tamagotchies[i].id == id {
                return tamagotchies[i]
            }
        }
        return nil
    }
    
    public func setSelectTamagochi(_ tamagotchi: Tamagotchi) {
        var tamagotchies = getTamagotchies()
        for i in 0..<tamagotchies.count {
            if tamagotchies[i].id == tamagotchi.id {
                tamagotchies[i] = tamagotchi
                break
            }
        }
        setTamagotchies(tamagotchies)
        
        UserDefaults.standard.set(tamagotchi.id, forKey: selectTamagotchiKey)
    }
    
    public func getNickname() -> String {
        guard let nickname = UserDefaults.standard.string(forKey: nicknameKey) else { return "티미" }
        return nickname
    }
    
    public func setNickname(_ nickname: String) {
        UserDefaults.standard.set(nickname, forKey: nicknameKey)
    }
}
