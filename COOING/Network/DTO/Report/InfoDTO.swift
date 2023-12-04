//
//  InfoDTO.swift
//  COOING
//
//  Created by 박윤빈 on 2023/12/04.
//

import Foundation

struct InfoDTO: Codable {
    let month, week: Int
    let name: String
    let birthMonth: Int
}
