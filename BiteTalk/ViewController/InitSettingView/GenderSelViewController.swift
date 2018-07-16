//
//  GenderSelViewController.swift
//  BiteTalk
//
//  Created by 신진욱 on 23/05/2018.
//  Copyright © 2018 신진욱. All rights reserved.
//

import UIKit

class GenderSelViewController: UIViewController {
    
    @IBOutlet weak var nextLabel: UIButton!
    @IBOutlet weak var bothLabel: UIButton!
    @IBOutlet weak var maleLabel: UIButton!
    @IBOutlet weak var femaleLabel: UIButton!
    var oldColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nextLabel.isHidden = true
        oldColor = nextLabel.tintColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handleBoth(_ sender: UIButton) {
        bothLabel.tintColor = .blue
        maleLabel.tintColor = oldColor
        femaleLabel.tintColor = oldColor
        nextLabel.isHidden = false
//        UserSetting.shared().gender = 2
        UserDefaults.standard.set(2, forKey: "gender")
    }
    @IBAction func handlemale(_ sender: UIButton) {
        bothLabel.tintColor = oldColor
        maleLabel.tintColor = .blue
        femaleLabel.tintColor = oldColor
        nextLabel.isHidden = false
//        UserSetting.shared().gender = 0
        UserDefaults.standard.set(0, forKey: "gender")
    }
    @IBAction func handleFemale(_ sender: UIButton) {
        bothLabel.tintColor = oldColor
        maleLabel.tintColor = oldColor
        femaleLabel.tintColor = .blue
        nextLabel.isHidden = false
//        UserSetting.shared().gender = 1
        UserDefaults.standard.set(1, forKey: "gender")
    }
}
