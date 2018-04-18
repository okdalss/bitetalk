//
//  LoginViewController.swift
//  BiteTalk
//
//  Created by 신진욱 on 17/04/2018.
//  Copyright © 2018 신진욱. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwdTextField: UITextField!
    var userRef: DatabaseReference?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if loginCheck() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if self.checkInitsetting() == false {
                print("go to init setting view...")
                let initViewCont = storyboard.instantiateViewController(withIdentifier: "initsettingview")
                self.present(initViewCont, animated: false, completion: nil)
            } else {
                print("go to main tabbar view...")
                let newviewcont = storyboard.instantiateViewController(withIdentifier: "maintabbar")
                self.present(newviewcont, animated: false, completion: nil)
            }
        } 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handleLogin(_ sender: UIButton) {
        guard let email = emailTextField.text, let passwd = passwdTextField.text else {
            print("email or password is not valid")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: passwd) { (user, error) in
            if let error = error {
                print(error)
                return
            }
            //successfully logged in our user
            self.userRef = Database.database().reference().child("users").child((user?.uid)!)
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            if self.checkInitsetting() == false {
                print("go to init setting view...")
                let initViewCont = storyboard.instantiateViewController(withIdentifier: "initsettingview")
                self.present(initViewCont, animated: true, completion: nil)
            } else {
                print("go to main tabbar view...")
                let newviewcont = storyboard.instantiateViewController(withIdentifier: "maintabbar")
                self.present(newviewcont, animated: true, completion: nil)
            }
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
}
