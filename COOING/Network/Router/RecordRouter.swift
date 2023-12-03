//
//  RecordRouter.swift
//  COOING
//
//  Created by 최지우 on 12/4/23.
//

import Foundation
import Moya

enum RecordRouter {
    case todayRecord(param: TodayRecordDTO)
}

extension RecordRouter: TargetType, AccessTokenAuthorizable {
  public var baseURL: URL {
      return URL(string: Config.baseURL)!
  }
  
  var path: String {
    switch self {
    case .todayRecord:
        return "/api/v1/answer/create/{cooingIndex}"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .todayRecord:
        return .post
    }
  }
  
  var task: Task {
    switch self {
    case .todayRecord(param: let param):
        return .requestJSONEncodable(param)
    }
  }

  var headers: [String : String]? {
      switch self {
      default:
//          let realm = RealmService()
//          let token = realm.getToken()
          let token = """
eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJBY2Nlc3NUb2tlbiIsImV4cCI6MTcwMTYyODMyMiwidXVpZCI6InRsc3JtYTIxNDJAbmF2ZXIuY29tIn0.__InuMpNF2DDFJ0haba15NArgDygVydkjia3AXR0zAPkjspatBoZLUAbIAtCUmVCFzaunX1lCOS_f8onXDGRfw
"""

          return ["Content-Type":"multipart/form-data",
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


