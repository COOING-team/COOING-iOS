//
//  GenericResponse.swift
//  COOING
//
//  Created by 최지우 on 12/3/23.
//

import Foundation

struct GenericResponse<T: Codable>: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: T
}
