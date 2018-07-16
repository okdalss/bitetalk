//
//  NicknameViewController.swift
//  BiteTalk
//
//  Created by 신진욱 on 24/05/2018.
//  Copyright © 2018 신진욱. All rights reserved.
//

import UIKit

class NicknameViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var nicknameTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nextButton.isHidden = true
        nicknameTextfield.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handlePrevious(_ sender: UIButton) {
        dismiss(animated: true) {
//            UserSetting.shared().nickname = ""
            UserDefaults.standard.set("", forKey: "nickname")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nicknameTextfield.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        if nicknameTextfield.text!.count != 0 {
//            UserSetting.shared().nickname = nicknameTextfield.text!
            UserDefaults.standard.set(nicknameTextfield.text!, forKey: "nickname")
            nextButton.isHidden = false
        } else {
            nextButton.isHidden = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toVoiceViewController" {
            if nicknameTextfield.text!.count == 0 {
                alertControll(message: "Enter nickname")
            } else {
                return
            }
        }
    }

}
