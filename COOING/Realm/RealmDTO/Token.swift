//
//  Token.swift
//  COOING
//
//  Created by 최지우 on 12/3/23.
//

import Realm
import RealmSwift

class Token: Object {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    
    @Persisted var accessToken = String()
    @Persisted var refreshToken = String()
    
    override static func primaryKey() -> String? {
      return "token"
    }
    
    convenience init(accessToken:String, refreshToken:String) {
        self.init()
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
    
}

