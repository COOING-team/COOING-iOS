//
//  SpeechRecognitionResponse.swift
//  COOING
//
//  Created by 최지우 on 12/4/23.
//

import Foundation

struct SpeechRecognitionResponse: Codable {
    let text: String
    let quota: Int
}
