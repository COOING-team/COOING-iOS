//
//  ClovaSpeechService.swift
//  COOING
//
//  Created by 최지우 on 12/4/23.
//
import Foundation

import AVFoundation
import Moya

enum ClovaSpeechService {
    case recognizeAudio(audioData: Data, language: String)
}

extension ClovaSpeechService: TargetType {
    var baseURL: URL {
        return URL(string: "https://clovaspeech-gw.ncloud.com")!
    }
    
    var path: String {
        switch self {
        case .recognizeAudio:
            return "/recog/v1/stt"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var task: Task {
        switch self {
        case .recognizeAudio(let audioData, let language):
            // Query parameters
            var params: [String: Any] = [:]
            params["lang"] = language
            
            // Custom encoding to add query parameters to the URL
            return .requestCompositeData(bodyData: audioData, urlParameters: params)
        }
    }
    
    var headers: [String : String]? {
        return [
            "X-CLOVASPEECH-API-KEY": "f050b703c495437f9d8cb8cd178d3cf5",
            "Content-Type": "application/octet-stream"
        ]
    }
    
    var sampleData: Data {
        return Data()
    }
}
