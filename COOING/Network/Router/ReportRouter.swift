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
    case frequent
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
        case .frequent:
            return "/api/v1/report/frequent"
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
        case .frequent:
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
        case .frequent:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        default:
            let token = RealmService.shared.getToken()
            return ["Content-Type":"application/json",
                    "Authorization": "Bearer \(token)"]
        }
    }
}

