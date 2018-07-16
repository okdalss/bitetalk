//
//  IntroduceViewController.swift
//  BiteTalk
//
//  Created by 신진욱 on 23/05/2018.
//  Copyright © 2018 신진욱. All rights reserved.
//
// TODO: add animation on textlabel

import UIKit

class IntroduceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        IntroTextLabel.addGestureRecognizer(tap)
        IntroTextLabel.isUserInteractionEnabled = true
        
        print("test.....................")
        print(UserDefaults.standard.string(forKey: "uid"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var IntroTextLabel: UILabel!
    
    @objc
    func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            toTheView(viewName: "genderselview")
        }
    }

}
