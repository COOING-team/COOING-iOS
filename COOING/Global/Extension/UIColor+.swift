//
//  UIColor+.swift
//  COOING
//
//  Created by 박윤빈 on 2023/11/05.
//

import UIKit

extension UIColor {
    
    static var cooingYellow: UIColor {
        return UIColor(hex: "#FFD277")
    }

    static var cooingBrown: UIColor {
        return UIColor(hex: "#4F4D43")
    }

    static var cooingBrown2: UIColor {
        return UIColor(hex: "#C1BC9C")
    }
    
    static var cooingGray1: UIColor {
        return UIColor(hex: "#4F4D43", alpha: 0.2)
    }
    
    static var cooingGray2: UIColor {
        return UIColor(hex: "#4F4D43", alpha: 0.05)
    }
    
    static var navGray: UIColor {
        return UIColor(hex: "#898989")
    }
    
    static var d9Gray: UIColor {
        return UIColor(hex: "#D9D9D9", alpha: 0.4)
    }

}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        assert(hexFormatted.count == 6, "Invalid hex code used.")
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: alpha)
    }
}
