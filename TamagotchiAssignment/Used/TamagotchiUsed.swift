//
//  TamagotchiUsed.swift
//  TamagotchiAssignment
//
//  Created by Minjae Kim on 6/12/24.
//

import UIKit

enum TamagotchiUsed {
    
    enum Color {
        static let tamagotchiBackgroundColor = UIColor(red: 245/255, green: 252/255, blue: 252/255, alpha: 1)
        static let tamagotchiButtonBackgroundColor = UIColor(red: 228/255, green: 235/255, blue: 237/255, alpha: 1)
        static let tamagotchilightBackgroundColor = UIColor(red: 222/255, green: 230/255, blue: 240/255, alpha: 1)
        static let tamagotchiBorderColor = UIColor(red: 77/255, green: 106/255, blue: 120/255, alpha: 0.8)
    }
    
    enum Font {
        static let bold11 = UIFont.systemFont(ofSize: 11, weight: .bold)
        static let bold13 = UIFont.systemFont(ofSize: 13, weight: .bold)
        static let bold14 = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        static let regular14 = UIFont.systemFont(ofSize: 14, weight: .regular)
    }

    enum NotificationCenterName {
        static let selectButton = "selectButton"
        static let resetButton = "resetButton"
    }

    enum TamagotchiSelectType {
        case select, change
        
        var naviagtionTitle: String {
            switch self {
            case .select:
                return "다마고치 선택하기"
            case .change:
                return "다마고치 변경하기"
            }
        }
        
        var popupButtonTitle: String {
            switch self {
            case .select:
                return "선택하기"
            case .change:
                return "변경하기"
            }
        }
    }
    
    enum ReusableCellUsedTo {
        case main, etc
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
}
