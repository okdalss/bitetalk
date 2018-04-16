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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newviewcont = storyboard.instantiateViewController(withIdentifier: "maintabbar")
            self.present(newviewcont, animated: true, completion: {
                print("handleLogin.present.completion")
            })
        }
    }
}
