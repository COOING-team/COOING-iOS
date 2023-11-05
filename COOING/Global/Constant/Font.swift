//
//  Font.swift
//  COOING
//
//  Created by 박윤빈 on 2023/11/05.
//

import UIKit

enum AppFontName: String {
    
    case semiBoldFont = "SUITE-SemiBold"
    case mediumFont = "SUITE-Medium"
    case boldFont = "SUITE-Bold"
    case extraBoldFont = "SUITE-ExtraBold"
    
    var name: String {
        return self.rawValue
    }
}
