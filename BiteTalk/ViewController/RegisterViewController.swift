//
//  RegisterViewController.swift
//  BiteTalk
//
//  Created by 신진욱 on 17/04/2018.
//  Copyright © 2018 신진욱. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var nicknameTextField: UITextField!
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
    
    @IBAction func handleRegister(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwdTextField.text, let name = nicknameTextField.text else {
            print("name or email or password is not valid")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print(error as Any)
                return
            }
            guard let uid = user?.uid else {
                return
            }
            
            //successfully authenticated user
            let ref = Database.database().reference()
            let usersReference = ref.child("users").child(uid)
            let values = ["name": name, "email": email, "mychats": ""] as [String : Any]
            usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                if err != nil {
                    print(err as Any)
                    return
                }
            })
            
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newviewcont = storyboard.instantiateViewController(withIdentifier: "maintabbar")
            self.present(newviewcont, animated: true, completion: {
                print("handleRegister...present..completion.")
            })
            
        }
    }
}