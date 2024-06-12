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
    var subTitle: String?
}

struct Tamagotchi: Codable {
    let isAvailable: Bool
    let id: Int
    let name: String
    let introduce: String
    var rice: Int
    var water: Int
    var level: Int {
        let level = Int((Double(rice) / 5) + (Double(water) / 2)) / 10
        if level == 0 { return 1 }
        if level > 10 { return 10 }
        return level
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
