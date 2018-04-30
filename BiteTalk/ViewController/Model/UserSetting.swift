//
//  UserSetting.swift
//  BiteTalk
//
//  Created by 신진욱 on 27/04/2018.
//  Copyright © 2018 신진욱. All rights reserved.
//

import Foundation
import Firebase

class UserSetting {
    
    var nickname: String = ""
    var gender: Int?
    var language: [String]?
    var toSay: String?
    var voice: URL?
    
    private static var sharedUserSetting: UserSetting = {
        let userSetting = UserSetting(uid: (Auth.auth().currentUser?.uid)!)
        return userSetting
    }()
    
    let uid: String
    
    private init(uid: String) {
        self.uid = uid
    }
    
    class func shared() -> UserSetting {
        return sharedUserSetting
    }
}
