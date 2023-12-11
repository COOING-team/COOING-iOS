//
//  AuthRouter.swift
//  COOING
//
//  Created by 최지우 on 12/3/23.
//

import Foundation
import Moya

enum AuthRouter {
    case login(param: LoginRequestDTO)
}

extension AuthRouter: TargetType {
  public var baseURL: URL {
      return URL(string: Config.baseURL)!
  }
  
  var path: String {
    switch self {
    case .login:
        return "/api/v1/auth/login"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .login:
        return .post
    }
  }
  
  var task: Task {
    switch self {
    case .login(param: let param):
        return .requestJSONEncodable(param)
    }
  }

  var headers: [String: String]? {
    switch self {
    default:
      return ["Content-Type": "application/json"]
    }
  }
}
