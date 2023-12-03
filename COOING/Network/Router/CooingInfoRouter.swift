//
//  CooingInfoRouter.swift
//  COOING
//
//  Created by 최지우 on 12/4/23.
//

import Foundation

import Moya

enum CooingInfoRouter {
    case createBaby(name: String, sex: String, birth: String)
}

extension CooingInfoRouter: TargetType, AccessTokenAuthorizable {
    public var baseURL: URL {
        return URL(string: Config.baseURL)!
    }

    var path: String {
        switch self {
        case .createBaby:
            return "/api/v1/auth/baby"
        }
    }

    var method: Moya.Method {
        switch self {
        case .createBaby:
            return .post
        }
    }

    var task: Task {
        switch self {
        case let .createBaby(name, sex, birth):
            let parameters = ["name": name, "sex": sex, "birth": birth]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }

    var headers: [String: String]? {
        let realm = RealmService()
        let token = realm.getToken()
        return ["Content-Type":"application/json",
                "Authorization": "Bearer \(token)"]
    }

    var sampleData: Data {
        switch self {
        case .createBaby:
            return Data() // Provide sample data for testing if needed.
        }
    }
    
    var authorizationType: Moya.AuthorizationType? {
        switch self {
        default:
            return .bearer
        }
    }
}
