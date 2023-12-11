//
//  IdentityTokenDTO.swift
//  COOING
//
//  Created by 최지우 on 12/3/23.
//

import Foundation

struct IdentityTokenDTO: Codable {
    let accessToken: String
    let refreshToken: String
}
