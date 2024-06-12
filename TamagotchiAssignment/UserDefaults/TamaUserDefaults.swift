//
//  TamaUserDefaults.swift
//  TamagotchiAssignment
//
//  Created by Minjae Kim on 6/12/24.
//

import Foundation

enum UserDefaultsKey: String, CaseIterable {
    case isFirstOpenedApp = "isFirstOpenedApp"
    case selectedID = "selectedID"
    case nickname = "nickname"
    case tamagotchies = "tamagotchies"
}

@propertyWrapper
struct UserDefaultWrapper<T: Codable> {
    private let key: String
    private let defaultValue: T?
    private let userDefaults = UserDefaults.standard

    init(key: String, defaultValue: T?) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T? {
        get {
            if let data = userDefaults.object(forKey: key) as? Data {
                if let value = try? JSONDecoder().decode(T.self, from: data) {
                    return value
                }
            }
            return defaultValue
        }
        set {
            if let encoded = try? JSONEncoder().encode(newValue) {
                userDefaults.setValue(encoded, forKey: key)
            }
        }
    }
}
