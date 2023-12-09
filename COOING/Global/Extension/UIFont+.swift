//
//  UIFont+.swift
//  COOING
//
//  Created by 박윤빈 on 2023/11/05.
//

import UIKit

extension UIFont {
    
    class func title1() -> UIFont {
        return UIFont(name: AppFontName.boldFont.rawValue, size: 23.adjusted)!
    }
    
    class func title2() -> UIFont {
        return UIFont(name: AppFontName.extraBoldFont.rawValue, size: 20.adjusted)!
    }
    
    class func title3() -> UIFont {
        return UIFont(name: AppFontName.boldFont.rawValue, size: 18.adjusted)!
    }

    class func body1() -> UIFont {
        return UIFont(name: AppFontName.semiBoldFont.rawValue, size: 15.adjusted)!
    }
    
    class func body2() -> UIFont {
        return UIFont(name: AppFontName.mediumFont.rawValue, size: 15.adjusted)!
    }
    
    class func body3() -> UIFont {
        return UIFont(name: AppFontName.semiBoldFont.rawValue, size: 13.adjusted)!
    }
    
    class func body4() -> UIFont {
        return UIFont(name: AppFontName.mediumFont.rawValue, size: 13.adjusted)!
    }
    
    class func body5() -> UIFont {
        return UIFont(name: AppFontName.boldFont.rawValue, size: 10.adjusted)!
    }
    
    class func body6() -> UIFont {
        return UIFont(name: AppFontName.mediumFont.rawValue, size: 10.adjusted)!
    }
    
    class func button1() -> UIFont {
        return UIFont(name: AppFontName.extraBoldFont.rawValue, size: 18.adjusted)!
    }
    
    class func button2() -> UIFont {
        return UIFont(name: AppFontName.boldFont.rawValue, size: 22.adjusted)!
    }
    
    class func button3() -> UIFont {
        return UIFont(name: AppFontName.extraBoldFont.rawValue, size: 10.adjusted)!
    }
    
    class func popup() -> UIFont {
        return UIFont(name: AppFontName.mediumFont.rawValue, size: 13.adjusted)!
    }
    
    class func nav() -> UIFont {
        return UIFont(name: AppFontName.semiBoldFont.rawValue, size: 10.adjusted)!
    }
    
    class func report1() -> UIFont {
        return UIFont(name: AppFontName.mediumFont.rawValue, size: 11.adjusted)!
    }
    
    class func report2() -> UIFont {
        return UIFont(name: AppFontName.extraBoldFont.rawValue, size: 15.adjusted)!
    }
}
