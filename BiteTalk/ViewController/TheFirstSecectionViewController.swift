//
//  TheFirstSecectionViewController.swift
//  BiteTalk
//
//  Created by 신진욱 on 03/05/2018.
//  Copyright © 2018 신진욱. All rights reserved.
//

import UIKit
import Firebase

class TheFirstSecectionViewController: UIViewController {
    
    var userRef: DatabaseReference?
    var loginCheckResult: Bool?
    var initSettingResult: Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
        loginCheckResult = loginCheck()
        initSettingResult = checkInitsetting()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let _ = loginCheckResult, let _ = initSettingResult else {
            print("something wrong")
            return
        }
        if loginCheckResult! {
            if self.checkInitsetting() == false {
                print("go to init setting view...")
                let initViewCont = storyboard.instantiateViewController(withIdentifier: "initsettingview")
                self.present(initViewCont, animated: false, completion: nil)
            } else {
                print("go to main tabbar view...")
                let newviewcont = storyboard.instantiateViewController(withIdentifier: "maintabbar")
                self.present(newviewcont, animated: false, completion: nil)
            }
        } else {
            let newviewcont = storyboard.instantiateViewController(withIdentifier: "loginviewcont")
            self.present(newviewcont, animated: false, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginCheck() -> Bool {
        let auth = Auth.auth().currentUser?.uid
        if auth != nil {
            self.userRef = Database.database().reference().child("users").child(auth!)
            return true
        } else {
            print("auth is nil")
            return false
        }
    }
    
    func checkInitsetting() -> Bool {
        var initvalue = false
        if let userRef = userRef {
            userRef.child("init setting").observe(.value) { (snap) in
                initvalue = snap.value as! Bool
            }
        }
        return initvalue
    }

}
