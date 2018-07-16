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
    
    override func viewDidAppear(_ animated: Bool) {
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (timer) in
            self.toTheView(viewName: "friendsview")
        }
    }
    
    func saveUserSettingToDdatabase() {
//        if UserSetting.shared().userSettingCheck() {
        if UserDefaults.standard.userDefaultsCheck() {
//            UserSetting.shared().numFriends = 0
//            UserSetting.shared().numCell = 3
            UserDefaults.standard.set(0, forKey: "numFriends")
            UserDefaults.standard.set(3, forKey: "numCell")
//            UserSetting.shared().saveToDatabase_new()
            UserDefaults.standard.saveToDatabase()
//            UserSetting.shared().saveVoiceToStorage()
            UserDefaults.standard.saveToStorage()
        }
    }
}
