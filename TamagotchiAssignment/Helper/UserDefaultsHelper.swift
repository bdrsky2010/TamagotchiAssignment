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
    
    func getIsNotFirstMeetWithTamagotchi() -> Bool {
        return UserDefaults.standard.bool(forKey: isNotFirstMeetWithTamagotchiAppKey)
    }
    
    func setIsNotFirstMeetWithTamagochi(_ isFirst: Bool) {
        UserDefaults.standard.set(isFirst, forKey: isNotFirstMeetWithTamagotchiAppKey)
    }
    
    func getTamagotchies() -> [Tamagotchi] {
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
    
    func getSelectTamagotchi() -> Tamagotchi? {
        let id = UserDefaults.standard.integer(forKey: selectTamagotchiKey)
        let tamagotchies = getTamagotchies()
        
        for i in 0..<tamagotchies.count {
            if tamagotchies[i].id == id {
                return tamagotchies[i]
            }
        }
        return nil
    }
    
    func setSelectTamagochi(_ tamagotchi: Tamagotchi) {
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
    
    func getNickname() -> String {
        guard let nickname = UserDefaults.standard.string(forKey: nicknameKey) else { return "대장" }
        return nickname
    }
    
    func setNickname(_ nickname: String) {
        UserDefaults.standard.set(nickname, forKey: nicknameKey)
    }
    
    func resetTamagochi() {
        UserDefaults.standard.removeObject(forKey: isNotFirstMeetWithTamagotchiAppKey)
        UserDefaults.standard.removeObject(forKey: tamagotchiKey)
        UserDefaults.standard.removeObject(forKey: selectTamagotchiKey)
        UserDefaults.standard.removeObject(forKey: nicknameKey)
        UserDefaults.standard.removeObject(forKey: tamagotchiTypeKey)
    }
}
