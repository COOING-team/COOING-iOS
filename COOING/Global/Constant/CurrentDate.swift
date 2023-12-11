//
//  CurrentDate.swift
//  COOING
//
//  Created by 박윤빈 on 2023/12/10.
//

import UIKit

public enum CurrentDate {
    
    static let calendar = Calendar.current

    static var year: Int {
        return calendar.component(.year, from: Date())
    }

    static var month: Int {
        return calendar.component(.month, from: Date())
    }

    static var day: Int {
        return calendar.component(.day, from: Date())
    }
    
    static var week: Int = Int()
//    {
//        let date = Date()
//        let components = calendar.dateComponents([.year, .month], from: date)
//
//        // 해당 월의 첫째 날을 구합니다.
//        guard let firstOfMonth = calendar.date(from: components) else { return 0 }
//
//        // 첫째 날과 현재 날짜의 주차 차이를 계산합니다.
//        let weekOfMonth = calendar.component(.weekOfMonth, from: date)
//        return weekOfMonth - 1
//    }
}
