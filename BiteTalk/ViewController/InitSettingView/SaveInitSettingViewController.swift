//
//  SaveInitSettingViewController.swift
//  BiteTalk
//
//  Created by 신진욱 on 25/05/2018.
//  Copyright © 2018 신진욱. All rights reserved.
//

import UIKit

class SaveInitSettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        saveUserSettingToDdatabase()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveUserSettingToDdatabase() {
        if UserSetting.shared().userSettingCheck() {
            UserSetting.shared().saveToDatabase_new()
            UserSetting.shared().saveVoiceToStorage()
        }
    }
}
