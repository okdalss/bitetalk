//
//  VoiceViewController.swift
//  BiteTalk
//
//  Created by 신진욱 on 24/05/2018.
//  Copyright © 2018 신진욱. All rights reserved.
//

import UIKit

class VoiceViewController: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nextButton.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func handlePrevious(_ sender: UIButton) {
        dismiss(animated: true) {
            UserSetting.shared().voice = nil
        }
    }
    

}
