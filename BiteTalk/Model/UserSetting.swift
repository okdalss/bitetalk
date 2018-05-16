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
    var toSay: String = ""
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
    
    func checkUserSetting() -> Bool {
        if nickname.count != 0 && toSay.count != 0 {
            guard let gen = gender, let lang = language, let voice = voice else {
                return false
            }
            return true
        } else {
            return false
        }
    }
    
    func saveToDatabase() {
        let afterUserRef = Database.database().reference().child("users").child("after_init")
        let beforeUserRef = Database.database().reference().child("users").child("before_init")
        
        beforeUserRef.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            afterUserRef.child(self.uid).setValue(snapshot.value)
            let userval = ["nickname": self.nickname, "gender": self.gender, "language": self.language, "toSay": self.toSay] as [String : Any]
            afterUserRef.child(self.uid).updateChildValues(userval)
            afterUserRef.child(self.uid).updateChildValues(userval, withCompletionBlock: { (error, ref) in
                beforeUserRef.removeValue()
            })
        }
    }
    
    func saveVoiceToStorage() {
        let voiceRef = Storage.storage().reference().child("/welcome_voice")
        voiceRef.child(uid).putFile(from: voice!)
    }

}
