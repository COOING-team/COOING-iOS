//
//  RealmService.swift
//  COOING
//
//  Created by 최지우 on 12/3/23.
//

import RealmSwift
import Realm

class RealmService {
    
    static let shared = RealmService()
    
    let realm = try! Realm()

    func addToken(accessToken:String,refreshToken:String) {
        let token = Token(accessToken: accessToken,refreshToken: refreshToken)
        try! realm.write{
            realm.add(token)
        }
    }

    func getToken() -> String {
        let token = realm.objects(Token.self)
        return token.last?.accessToken ?? ""
    }

    func getRefreshToken() -> String {
        let token = realm.objects(Token.self)
        return token.last?.refreshToken ?? ""
    }
    
    func isAccessTokenPresent() -> Bool {
        return getToken() != ""
    }

    func resetDB(){
        try! realm.write {
            realm.deleteAll()
        }
    }

//    func addUser(accessToken: String, nickName: String) {
//        let nickName = NickName(accessToken: accessToken, nickName: nickName)
//        try! realm.write {
//            realm.add(nickName)
//        }
//    }

    init() {
        print("Realm Location: ", realm.configuration.fileURL ?? "cannot find location.")
    }

}


