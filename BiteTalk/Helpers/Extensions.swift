//
//  Extensions.swift
//  BiteTalk
//
//  Created by 신진욱 on 24/04/2018.
//  Copyright © 2018 신진욱. All rights reserved.
//

import UIKit
import Firebase

extension UIViewController {
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func toTheView(viewName: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let newviewcont = storyboard.instantiateViewController(withIdentifier: viewName)
        print("go to \(viewName)")
        self.present(newviewcont, animated: false, completion: nil)
    }
    
    func alertControll(message: String) {
        let alertCont = UIAlertController(title: message, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action) in
            return
        }
        alertCont.addAction(okAction)
        self.present(alertCont, animated: true, completion: nil)
    }
}

extension UserDefaults {
    func userDefaultsCheck() -> Bool {
        if UserDefaults.standard.string(forKey: "nickname")?.count != 0 {
            guard let _ = UserDefaults.standard.stringArray(forKey: "language"), let _ = UserDefaults.standard.url(forKey: "voice") else {
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
        
        beforeUserRef.child(UserDefaults.standard.string(forKey: "uid")!).observeSingleEvent(of: .value) { (snapshot) in
            let email = snapshot.childSnapshot(forPath: "email").value
            let userval = ["email": email, "nickname": UserDefaults.standard.string(forKey: "nickname"), "gender": UserDefaults.standard.integer(forKey: "gender"), "language": UserDefaults.standard.stringArray(forKey: "language"), "numFriends": UserDefaults.standard.integer(forKey: "numFriends"), "numCell": UserDefaults.standard.integer(forKey: "numCell")] as [String : Any]
            afterUserRef.child(UserDefaults.standard.string(forKey: "uid")!).updateChildValues(userval, withCompletionBlock: { (error, refence) in
//                beforeUserRef.child(UserSetting.shared().uid).removeValue()
                beforeUserRef.child(UserDefaults.standard.string(forKey: "uid")!).removeValue()
                print("remove \(UserDefaults.standard.string(forKey: "uid")!) in before directory.")
                
            })
        }
    }
    
    func saveToStorage() {
        let voiceRef = Storage.storage().reference().child("/welcome_voice")
        voiceRef.child(UserDefaults.standard.string(forKey: "uid")!).putFile(from: UserDefaults.standard.url(forKey: "voice")!)
    }
    
    func setFromDatabase(completion: (()->())? = nil) {
        let afterUserRef = Database.database().reference().child("users").child("after_init")
        afterUserRef.child(UserDefaults.standard.string(forKey: "uid")!).observeSingleEvent(of: .value) { (snap) in
            
            if let email = snap.childSnapshot(forPath: "email").value, let gender = snap.childSnapshot(forPath: "gender").value, let language = snap.childSnapshot(forPath: "language").value, let nickname = snap.childSnapshot(forPath: "nickname").value, let numCell = snap.childSnapshot(forPath: "numCell").value, let numFriends = snap.childSnapshot(forPath: "numFriends").value {
                UserDefaults.standard.set(email, forKey: "email")
                UserDefaults.standard.set(gender, forKey: "gender")
                UserDefaults.standard.set(language, forKey: "language")
                UserDefaults.standard.set(nickname, forKey: "nickname")
                UserDefaults.standard.set(numCell, forKey: "numCell")
                UserDefaults.standard.set(numFriends, forKey: "numFriends")
            }
            completion?()
        }
    }
}
