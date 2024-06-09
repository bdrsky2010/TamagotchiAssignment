//
//  TamagotchiModel.swift
//  TamagotchiAssignment
//
//  Created by Minjae Kim on 6/8/24.
//

import Foundation

struct Setting {
    let mainImage: String
    let mainTitle: String
    let subTitle: String?
}

struct NotificationCenterName {
    static let selectButton = "selectButton"
    static let resetButton = "resetButton"
}

enum TamagotchiSelectType {
    case select, change
}

enum TamagotchiType: CaseIterable {
    case 따끔따끔
    case 방실방실
    case 반짝반짝
    
    var id: Int {
        switch self {
        case .따끔따끔:
            return 1
        case .방실방실:
            return 2
        case .반짝반짝:
            return 3
        }
    }
    
    var name: String {
        return "\(String(describing: self)) \("다마고치")"
    }
    
    var introduce: String {
        switch self {
        case .따끔따끔:
            return "저는 선인장 다마고치입니다. 키는 2cm\n몸무게는 150g이에요.\n성격은 소심하지만 마음은 따뜻해요.\n열심히 잘 먹고 잘 클 자신은 있답니다.\n반가워요 주인님!!!"
        case .방실방실:
            return "저는 방실방실 다마고치입니당 키는 100km\n몸무게는 150톤이에용\n성격은 화끈하게 날라다닙니당~!\n열심히 잘 먹고 잘 클 자신은\n있답니당 방실방실"
        case .반짝반짝:
            return "안녕하세요! 저는 반짝반짝 다마고치입니다!\n저는 별처럼 반짝이는 몸을 가진 귀여운 다마고치입니다.\n저와 함께 즐거운 시간을 보내고\n소중한 추억을 만들어 주세요 주인님!!!"
        }
    }
}

struct Tamagotchi: Codable {
    let isAvailable: Bool
    let id: Int
    let name: String
    let introduce: String
    var rice: Int
    var water: Int
    var level: Int {
        let level = Int((Double(rice) / 5) + (Double(water) / 2))
        switch level {
        case 0..<20: return 1
        case 20..<30: return 2
        case 30..<40: return 3
        case 40..<50: return 4
        case 50..<60: return 5
        case 60..<70: return 6
        case 70..<80: return 7
        case 80..<90: return 8
        case 90..<100: return 9
        default: return 10
        }
    }
    var stringLevel: String {
        return String(level)
    }
    
    init(isAvailable: Bool, id: Int, name: String, introduce: String, rice: Int, water: Int) {
        self.isAvailable = isAvailable
        self.id = id
        self.name = name
        self.introduce = introduce
        self.rice = rice
        self.water = water
    }
    
    init(isAvailable: Bool, id: Int, name: String, introduce: String) {
        self.init(isAvailable: isAvailable, id: id, name: name, introduce: introduce, rice: 0, water: 0)
    }
    
    func addRice(_ count: Int) -> Tamagotchi {
        return Tamagotchi(isAvailable: isAvailable, id: id, name: name, introduce: introduce, rice: rice + count, water: water)
    }
    
    func addWater(_ count: Int) -> Tamagotchi {
        return Tamagotchi(isAvailable: isAvailable, id: id, name: name, introduce: introduce, rice: rice, water: water + count)
    }
}
