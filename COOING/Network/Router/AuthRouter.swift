//
//  AuthRouter.swift
//  COOING
//
//  Created by 최지우 on 12/3/23.
//

import Foundation
import Moya

enum AuthRouter {
    case kakaoLogin(param: KakaoLoginRequestDTO)
}

extension AuthRouter: TargetType {
  public var baseURL: URL {
      return URL(string: Config.baseURL)!
  }
  
  var path: String {
    switch self {
    case .kakaoLogin:
        return "/api/v1/auth/kakao-login"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .kakaoLogin:
        return .post
    }
  }
  
  var task: Task {
    switch self {
    case .kakaoLogin(param: let param):
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
