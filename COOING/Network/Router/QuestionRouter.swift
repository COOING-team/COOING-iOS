//
//  QuestionRouter.swift
//  COOING
//
//  Created by 최지우 on 12/4/23.
//

import Foundation

import Moya

enum QuestionRouter {
    case getQuestion(cooingIndex: Int)
}

extension QuestionRouter: TargetType {
    public var baseURL: URL {
        return URL(string: Config.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getQuestion(let cooingIndex):
            return "/api/v1/question/\(cooingIndex)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getQuestion:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .getQuestion:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        let realm = RealmService()
        let token = realm.getToken()
        return ["Content-Type":"application/json",
                "Authorization": "Bearer \(token)"]
    }

    var sampleData: Data {
        return Data()
    }
}
