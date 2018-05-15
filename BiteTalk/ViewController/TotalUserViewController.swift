//
//  TotalUserViewController.swift
//  BiteTalk
//
//  Created by 신진욱 on 11/05/2018.
//  Copyright © 2018 신진욱. All rights reserved.
//

import UIKit
import Firebase

class TotalUserViewController: UIViewController {
    
    var numOfButton = 2
    let colors = [UIColor.black, UIColor.blue, UIColor.brown]
    var buttons: [UIButton]?
    var button: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addButtons()
        observeUsers()
    }
    
    func addOneButton(x: Int, y: Int, width: Int, height: Int, color: UIColor) {
        button = UIButton(frame: CGRect(x: x, y: y, width: width, height: height))
        button?.backgroundColor = color
        button?.setTitle("this button", for: .normal)
//        button?.setTitleColor(UIColor.black, for: .normal)
        self.view.addSubview(button!)
    }
    
    func addButtons() {
        var x = 10, y = 30, width = 100, height = 100
        for butt in 0..<numOfButton {
            addOneButton(x: x, y: y, width: width, height: height, color: colors[butt])
            x = x + 105
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func observeUsers() {
        
        
        
    }
    
    @IBAction func handleLogout(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "loginviewcont")
//        self.dismiss(animated: true, completion: nil)
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
        self.present(loginViewController, animated: false, completion: nil)
    }

    
    


}
