//
//  User.swift
//  BiteTalk
//
//  Created by 신진욱 on 16/05/2018.
//  Copyright © 2018 신진욱. All rights reserved.
//

import Foundation

class User: NSObject {
    var code: String?
    var gender: Int?
    var language: [String]?
    var nickname: String?
    var toSay: String?
    
    init(code: String) {
        self.code = code
    }
    
    func settingFromDic(dic: [String: Any]?) {
        gender = dic?["gender"] as? Int
        if let langArray = dic?["language"] as? [Int: String] {
            for lang in langArray {
                print(lang)
            }
        }
        nickname = dic?["nickname"] as? String
        toSay = dic?["toSay"] as? String
    }
}
