//
//  UIFont+.swift
//  COOING
//
//  Created by 박윤빈 on 2023/11/05.
//

import UIKit

extension UIFont {
    
    class func title1() -> UIFont {
        return UIFont(name: AppFontName.boldFont.rawValue, size: 23)!
    }
    
    class func title2() -> UIFont {
        return UIFont(name: AppFontName.extraBoldFont.rawValue, size: 20)!
    }
    
    class func title3() -> UIFont {
        return UIFont(name: AppFontName.boldFont.rawValue, size: 18)!
    }

    class func body1() -> UIFont {
        return UIFont(name: AppFontName.semiBoldFont.rawValue, size: 15)!
    }
    
    class func body2() -> UIFont {
        return UIFont(name: AppFontName.mediumFont.rawValue, size: 15)!
    }
    
    class func body3() -> UIFont {
        return UIFont(name: AppFontName.semiBoldFont.rawValue, size: 13)!
    }
    
    class func body4() -> UIFont {
        return UIFont(name: AppFontName.mediumFont.rawValue, size: 13)!
    }
    
    class func body5() -> UIFont {
        return UIFont(name: AppFontName.boldFont.rawValue, size: 10)!
    }
    
    class func body6() -> UIFont {
        return UIFont(name: AppFontName.mediumFont.rawValue, size: 10)!
    }
    
    class func button1() -> UIFont {
        return UIFont(name: AppFontName.extraBoldFont.rawValue, size: 18)!
    }
    
    class func button2() -> UIFont {
        return UIFont(name: AppFontName.boldFont.rawValue, size: 22)!
    }
    
    class func button3() -> UIFont {
        return UIFont(name: AppFontName.extraBoldFont.rawValue, size: 10)!
    }
    
    class func popup() -> UIFont {
        return UIFont(name: AppFontName.mediumFont.rawValue, size: 13)!
    }
    
    class func nav() -> UIFont {
        return UIFont(name: AppFontName.semiBoldFont.rawValue, size: 10)!
    }
    
    class func report1() -> UIFont {
        return UIFont(name: AppFontName.mediumFont.rawValue, size: 11)!
    }
    
    class func report2() -> UIFont {
        return UIFont(name: AppFontName.extraBoldFont.rawValue, size: 15)!
    }
}
