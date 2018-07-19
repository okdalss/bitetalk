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
        if UserDefaults.standard.userDefaultsCheck() {
            UserDefaults.standard.set(0, forKey: "numFriends")
            UserDefaults.standard.set(3, forKey: "numCell")
            UserDefaults.standard.saveToDatabase()
            UserDefaults.standard.saveToStorage()
        }
    }
}
