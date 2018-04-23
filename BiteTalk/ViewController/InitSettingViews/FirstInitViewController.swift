//
//  FirstInitViewController.swift
//  BiteTalk
//
//  Created by 신진욱 on 18/04/2018.
//  Copyright © 2018 신진욱. All rights reserved.
//

import UIKit

class FirstInitViewController: UIViewController, UITextFieldDelegate {
    
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    @IBOutlet weak var nicknameTextfield: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
//        // background Img
//        let backgroundImage = UIImageView(image: UIImage(named: "initsettingimg"))
//        view.insertSubview(backgroundImage, at: 0)
//        //
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
        let viewCont = storyBoard.instantiateViewController(withIdentifier: "initsettingview") as? InitSettingViewController
        viewCont?.nickname = nicknameTextfield.text
    }
}
