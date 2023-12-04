//
//  RecordRouter.swift
//  COOING
//
//  Created by 최지우 on 12/4/23.
//

import Foundation
import Moya

enum RecordRouter {
    case uploadAudioURL(Data)
    case todayRecord(cooingIndex: Int, param: TodayRecordDTO)
}

extension RecordRouter: TargetType, AccessTokenAuthorizable {
  public var baseURL: URL {
      return URL(string: Config.baseURL)!
  }
  
var path: String {
    switch self {
    case .uploadAudioURL:
        return "/api/v1/answer/save-audio"
    case .todayRecord(let cooingIndex, _):
        return "/api/v1/answer/create/\(cooingIndex)"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .uploadAudioURL, .todayRecord:
        return .post
    }
  }
  
    var task: Task {
        switch self {
        case .uploadAudioURL(let audioData):
            let formData = MultipartFormData(provider: .data(audioData), name: "audioFile", fileName: "file.wav", mimeType: "audio/wav")
            return .uploadMultipart([formData])
        case .todayRecord(_, let param):
            return .requestJSONEncodable(param)
        }
      }

  var headers: [String : String]? {
      let realm = RealmService()
      let token = realm.getToken()
      
      switch self {
      case .uploadAudioURL:
          return ["Content-Type":"multipart/form-data",
                  "Authorization": "Bearer \(token)"]
      case .todayRecord:
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
    
    var sampleData: Data {
        switch self {
        case .uploadAudioURL:
            return Data()
        case .todayRecord(_, let param):
            return try! JSONEncoder().encode(param)
        }
      }
}


