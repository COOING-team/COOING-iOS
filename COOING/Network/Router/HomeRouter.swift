//
//  HomeRouter.swift
//  COOING
//
//  Created by 최지우 on 12/4/23.
//

import Foundation

import Moya

enum HomeRouter {
    case getInfo
}

extension HomeRouter: TargetType {
    public var baseURL: URL {
        return URL(string: Config.baseURL)!
    }

    var path: String {
        switch self {
        case .getInfo:
            return "/api/v1/home/info"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getInfo:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .getInfo:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }

}
