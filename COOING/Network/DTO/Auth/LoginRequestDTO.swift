//
//  KakaoLoginRequestDTO.swift
//  COOING
//
//  Created by 최지우 on 12/3/23.
//

import Foundation

struct LoginRequestDTO: Codable {
    let name: String
    let email: String
    let oauthProvider: String
}
