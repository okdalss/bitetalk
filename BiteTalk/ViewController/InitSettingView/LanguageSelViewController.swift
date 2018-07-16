//
//  LanguageSelViewController.swift
//  BiteTalk
//
//  Created by 신진욱 on 24/05/2018.
//  Copyright © 2018 신진욱. All rights reserved.
//

import UIKit

class LanguageSelViewController: UIViewController {

    @IBOutlet weak var nextLabel: UIButton!
    @IBOutlet weak var selLangButton: UIButton!
    @IBOutlet weak var preButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nextLabel.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func handlePrevious(_ sender: UIButton) {
        dismiss(animated: true) {
//            UserSetting.shared().language = nil
            UserDefaults.standard.set(nil, forKey: "language")
        }
    }
}
