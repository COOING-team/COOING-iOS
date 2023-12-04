//
//  SecretNoteListDTO.swift
//  COOING
//
//  Created by 박윤빈 on 2023/12/04.
//

import Foundation

struct SecretNoteListDTO: Codable {
    let secretNoteLists: [SecretNoteList]
}

struct SecretNoteList: Codable {
    let month, week: Int
    let noteStatus: String
}
