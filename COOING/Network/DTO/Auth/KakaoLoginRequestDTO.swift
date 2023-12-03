//
//  KakaoLoginRequestDTO.swift
//  COOING
//
//  Created by 최지우 on 12/3/23.
//

import Foundation

struct KakaoLoginRequestDTO: Codable {
    let providerId: String
    let nickname: String
    let email: String
}
