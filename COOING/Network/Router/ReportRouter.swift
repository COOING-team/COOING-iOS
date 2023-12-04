//
//  ReportRouter.swift
//  COOING
//
//  Created by 박윤빈 on 2023/12/04.
//

import Foundation
import Moya

enum ReportRouter {
    case total
    case usingWord(year: Int, month: Int, week: Int)
    case secretNote(month: Int, week: Int)
    case secretNoteList(month: Int)
    case info
}

extension ReportRouter: TargetType {
    public var baseURL: URL {
        return URL(string: Config.baseURL)!
    }
    
    var path: String {
        switch self {
        case .total:
            return "/api/v1/report/total"
        case .usingWord:
            return "/api/v1/report/using-word"
        case .secretNote:
            return "/api/v1/report/secret-note"
        case .secretNoteList:
            return "/api/v1/report/secret-note-list"
        case .info:
            return "/api/v1/report/info"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .total:
            return .get
        case .usingWord:
            return .get
        case .secretNote:
            return .get
        case .secretNoteList:
            return .get
        case .info:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .total:
            return .requestPlain
        case .usingWord(year: let year, month: let month, week: let week):
            return .requestParameters(parameters: ["year": year,
                                                   "month": month,
                                                   "week": week],
                                      encoding: URLEncoding.queryString)
        case .secretNote(month: let month, week: let week):
            return .requestParameters(parameters: ["month": month,
                                                   "week": week],
                                      encoding: URLEncoding.queryString)
        case .secretNoteList(month: let month):
            return .requestParameters(parameters: ["month": month],
                                      encoding: URLEncoding.queryString)
        case .info:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        default:
            let token = RealmService.shared.getToken()
            return ["Content-Type":"application/json",
                    "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTcwMTY0Mzg5OCwidXVpZCI6InRsc3JtYTIxNDJAbmF2ZXIuY29tIn0.QvZh0a4p3zmf2o1HchY_HIXYYZhQe37vfaIGGAkmWXyg4mPpR6eLS7dSHRBy8elmdo5AMsRFqFpI206JQVyj9A"]
        }
    }
}

