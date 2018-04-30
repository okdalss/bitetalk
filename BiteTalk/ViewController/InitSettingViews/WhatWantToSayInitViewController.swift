//
//  WhatWantToSayInitViewController.swift
//  BiteTalk
//
//  Created by 신진욱 on 19/04/2018.
//  Copyright © 2018 신진욱. All rights reserved.
//

import UIKit

class WhatWantToSayInitViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var sayTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        sayTextField.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sayTextField.resignFirstResponder()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        let viewCont = parent?.parent as? InitSettingViewController
        updateSay()
        viewCont?.nextButton.isEnabled = true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let viewCont = parent?.parent as? InitSettingViewController
        viewCont?.nextButton.isEnabled = false
    }
    
    func updateSay() {
        UserSetting.shared().toSay = sayTextField.text
    }
}
