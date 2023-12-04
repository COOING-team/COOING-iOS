//
//  CooingDefaultInfoDTO.swift
//  COOING
//
//  Created by 최지우 on 12/4/23.
//

import Foundation

struct CooingDefaultInfoDTO: Codable {
    let name: String
    let month: Int
    let cooingDay: Int
    let todayRecord: Bool
}
