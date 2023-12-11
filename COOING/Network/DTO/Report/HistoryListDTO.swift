//
//  HistoryListDTO.swift
//  COOING
//
//  Created by 박윤빈 on 2023/12/11.
//

import Foundation

struct HistoryListDTO: Codable {
    let answerID: Int
    let content, createAt: String

    enum CodingKeys: String, CodingKey {
        case answerID = "answerId"
        case content, createAt
    }
}
