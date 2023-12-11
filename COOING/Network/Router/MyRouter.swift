//
//  MyRouter.swift
//  COOING
//
//  Created by 최지우 on 12/11/23.
//

import UIKit

import Moya

enum MyRouter {
    case myInfo
    case signOut
}

extension MyRouter: TargetType, AccessTokenAuthorizable {
    var baseURL: URL {
        return URL(string: Config.baseURL)!
    }
    
    var path: String {
        switch self {
        case .myInfo:
            return "/mypage/info"
        case .signOut:
            return "/user/signout"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .myInfo:
            return .get
        case .signOut:
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .myInfo:
            return .requestPlain
        case .signOut:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
//            let realm = RealmService()
            let token = RealmService.shared.getToken()
            return ["Content-Type":"application/json",
                    "Authorization": "Bearer \(token)"]
        }
    }
    
    var authorizationType: Moya.AuthorizationType? {
        switch self {
        default:
            return .bearer
        }
    }
}

