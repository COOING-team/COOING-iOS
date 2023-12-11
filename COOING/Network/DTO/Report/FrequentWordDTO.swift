//
//  FrequentWordDTO.swift
//  COOING
//
//  Created by 박윤빈 on 2023/12/10.
//

import Foundation

struct FrequentWordDTO: Codable {
    let frequentWords: FrequentWords
}

// MARK: - FrequentWords
struct FrequentWords: Codable {
    let fourthWord, fifthWord, firstWord, secondWord: Word
    let thirdWord: Word
}

// MARK: - Word
struct Word: Codable {
    let word: String
    let count: Int
}
