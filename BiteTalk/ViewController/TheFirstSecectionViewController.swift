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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if loginCheckResult == true {
            checkInitsetting()
        } else {
//            UserSetting.destroy()
            let domain = Bundle.main.bundleIdentifier!
            UserDefaults.standard.removePersistentDomain(forName: domain)
            toTheView(viewName: "loginviewcont")
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
            UserDefaults.standard.set(auth, forKey: "uid")
            return true
        } else {
            print("auth is nil")
            return false
        }
    }
    
    func checkInitsetting() {
        let beforeRef = Database.database().reference().child("users").child("before_init")
        let afterRef = Database.database().reference().child("users").child("after_init")
        
        afterRef.observeSingleEvent(of: .value) { (snap) in
//            if snap.hasChild(UserSetting.shared().uid) {
            if snap.hasChild(UserDefaults.standard.string(forKey: "uid")!) {
                self.toTheView(viewName: "maintabbar")
            } else {
                beforeRef.observeSingleEvent(of: .value) { (snap) in
//                    if snap.hasChild(UserSetting.shared().uid) {
                    if snap.hasChild(UserDefaults.standard.string(forKey: "uid")!) {
                        self.toTheView(viewName: "initsettingview")
                    } else {
                        print("something wrong in initsetting...")
                        self.handleLogout()
                    }
                }
            }
        }
    }
    
    func handleLogout() {
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "loginviewcont")
        //        self.dismiss(animated: true, completion: nil)
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
        self.present(loginViewController, animated: false, completion: nil)
    }

}
