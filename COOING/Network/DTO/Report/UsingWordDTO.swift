//
//  UsingWordDTO.swift
//  COOING
//
//  Created by 박윤빈 on 2023/12/04.
//

import Foundation

struct UsingWordDTO: Codable {
    let wordNum: [WordNum]
    let averageWordNum: Int
}

struct WordNum: Codable {
    let day: String
    let wordCount: Int
}
