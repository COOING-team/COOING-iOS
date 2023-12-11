//
//  HistoryRouter.swift
//  COOING
//
//  Created by 박윤빈 on 2023/12/11.
//

import Foundation

import Moya

enum HistoryRouter {
    case historyList(year: Int, month: Int)
    case historyDetail(id: Int)
}

extension HistoryRouter: TargetType {
    public var baseURL: URL {
        return URL(string: Config.baseURL)!
    }
    
    var path: String {
        switch self {

        case .historyList:
            return "/api/v1/collection"
        case .historyDetail(id: let id):
            return "/api/v1/collection/\(id)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .historyList:
            return .get
        case .historyDetail:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .historyDetail:
            return .requestPlain
        case .historyList(year: let year, month: let month):
            return .requestParameters(parameters: ["year": year,
                                                   "month": month],
                                      encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        let realm = RealmService()
        let token = realm.getToken()
        return ["Content-Type":"application/json",
                "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTcwMjMxNjI2MCwidXVpZCI6ImJpbjM5NTVAZGF1bS5uZXQifQ.KGb8KTaM4qlBV3hrwD7JIpdJpkjBOMQUB5mVUuXn6OKZ3xkasI3gpOIT8YWPIwxY1rCak5j_jL0kOYPhnJA5Jg"]
    }

    var sampleData: Data {
        return Data()
    }
}
