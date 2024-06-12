//
//  UserDefault.swift
//  TamagotchiAssignment
//
//  Created by Minjae Kim on 6/12/24.
//

import Foundation

enum UserDefaultsKey: String {
    case isFirstOpenedApp = "isFirstOpenedApp"
    case selectedTamagotchiID = "selectedTamagotchiID"
    case nickname = "nickname"
    case tamagotchies = "tamagotchies"
}

//@propertyWrapper
//struct UserDefault<T: Codable> {
//    
//    let key: UserDefaultsKey
//    let defaultValue: T?
//    let isCustomObject: Bool
//    let isArray: Bool
//    let userDefaults: UserDefaults = UserDefaults.standard
//    
//    var wrappedValue: T {
//        
//        get {
//            if isCustomObject { // 커스텀 타입일 때
//                
//                if let data = userDefaults.object(forKey: key.rawValue) as? Data {
//                    let decoder = JSONDecoder()
//                    if let value = decoder.decode(T.self, from: <#T##Data#>)
//                }
//                
//            } else { // 아닐 때
//                
//            }
//        }
//        
//        set {
//            
//        }
//    }
//    
//}
