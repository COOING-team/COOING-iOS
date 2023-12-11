//
//  HistoryDetailDTO.swift
//  COOING
//
//  Created by 박윤빈 on 2023/12/11.
//

import Foundation

// MARK: - Result
struct HistoryDetailDTO: Codable {
    let answerID: Int
    let content: String
    let cooingDay: Int
    let createAt, answerText, fileURL, comment: String

    enum CodingKeys: String, CodingKey {
        case answerID = "answerId"
        case content, cooingDay, createAt, answerText
        case fileURL = "fileUrl"
        case comment
    }
}
