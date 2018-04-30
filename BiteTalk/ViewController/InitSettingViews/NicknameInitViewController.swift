//
//  NicknameInitViewController.swift
//  BiteTalk
//
//  Created by 신진욱 on 18/04/2018.
//  Copyright © 2018 신진욱. All rights reserved.
//

import UIKit
import Firebase

class NicknameInitViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nicknameTextfield: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        nicknameTextfield.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nicknameTextfield.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        let viewCont = parent?.parent as? InitSettingViewController
        updateNickname()
        viewCont?.nextButton.isEnabled = true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let viewCont = parent?.parent as? InitSettingViewController
        viewCont?.nextButton.isEnabled = false
    }
    
    func updateNickname() {
            UserSetting.shared().nickname = nicknameTextfield.text!
    }
}
