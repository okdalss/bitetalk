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
    var userUid: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            self.checkInitsetting()
        }
    }
    
    func checkInitsetting() {
        let beforeRef = Database.database().reference().child("users").child("before_init")
        let afterRef = Database.database().reference().child("users").child("after_init")
        
        afterRef.observeSingleEvent(of: .value) { (snap) in
            if snap.hasChild(UserSetting.shared().uid) {
                self.toTheView(viewName: "maintabbar")
            } else {
                beforeRef.observeSingleEvent(of: .value) { (snap) in
                    if snap.hasChild(UserSetting.shared().uid) {
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
    
    func toTheView(viewName: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let newviewcont = storyboard.instantiateViewController(withIdentifier: viewName)
        print("go to \(viewName)")
        self.present(newviewcont, animated: false, completion: nil)
    }
    
    @IBAction func unwindToLoginView(segue: UIStoryboardSegue) {
        print("unwinded.")
    }
}
