//
//  GenderInitViewController.swift
//  BiteTalk
//
//  Created by 신진욱 on 24/04/2018.
//  Copyright © 2018 신진욱. All rights reserved.
//

import UIKit

class GenderInitViewController: UIViewController {
    
    @IBOutlet weak var genderSegmentControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        genderSegmentControl.selectedSegmentIndex = 2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            UserSetting.shared().gender = genderSegmentControl.selectedSegmentIndex
    }


}
