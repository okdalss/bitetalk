//
//  FriendsViewController.swift
//  BiteTalk
//
//  Created by 신진욱 on 11/05/2018.
//  Copyright © 2018 신진욱. All rights reserved.
//

import UIKit
import Firebase

class FriendsViewController: UIViewController {
    
    let colors = [UIColor.black, UIColor.blue, UIColor.brown]
    var buttons: [UIButton]?
    var button: UIButton?
    
    @IBOutlet weak var buttonView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if UserDefaults.standard.integer(forKey: "numCell") == 0 {
            UserDefaults.standard.setFromDatabase(completion: addButtonsCompletion)
        }
        addButtons(numOfUser: UserDefaults.standard.integer(forKey: "numCell"))
    }
    
    private func addButtonsCompletion() {
        addButtons(numOfUser: UserDefaults.standard.integer(forKey: "numCell"))
    }
    
    func addFriendtoCell(friendCode: String, cellNumber: Int) {
        // func. send requirement to server adding new friend. this receive friend code.
    }
    
    func addOneButton(x: Int, y: Int, width: Int, height: Int, color: UIColor) {
        button = FriendButton(frame: CGRect(x: x, y: y, width: width, height: height))
        button?.backgroundColor = color
        self.buttonView.addSubview(button!)
        print("button added...")
    }
    
    func addButtons(numOfUser: Int) {
        print("addButtons start...")
        var x = 10, y = 30, width = 100, height = 100
        for butt in 0..<numOfUser {
            addOneButton(x: x, y: y, width: width, height: height, color: colors[butt])
            x = x + 105
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var firstUpdate = true
    var lastChild: String?
    var users = [User]() {
        didSet {
            print("users setted... \(users)")
        }
    }
    
    func loadUsers(loadNum: UInt) {
        let afterInitUserRef = Database.database().reference().child("users").child("after_init")
        if firstUpdate {
            let query = afterInitUserRef.queryLimited(toFirst: loadNum)
            var firstSnap = true

            var observeIterNum = 1
            query.observe(.childAdded, with: { (snap) in
                self.addToUsersArray(snapshot: snap, firstUpdate: self.firstUpdate, firstSnap: firstSnap)
                self.lastChild = snap.key
                
                if observeIterNum == loadNum {
                    DispatchQueue.main.async(execute: {
                        //                    self.chatTableView.reloadData()
                        self.addButtons(numOfUser: self.users.count)
                    })
                }
                if firstSnap ==  true {
                    firstSnap = false
                }
                else {
                    self.firstUpdate = false
                }
                observeIterNum = observeIterNum + 1
                query.removeAllObservers()
            })
        } else {
            let query = afterInitUserRef.queryOrderedByKey().queryStarting(atValue: lastChild!).queryLimited(toFirst: loadNum)
            var firstSnap = true
            
            var observeIterNum = 1
            query.observe(.childAdded, with: { (snap) in
                self.addToUsersArray(snapshot: snap, firstUpdate: self.firstUpdate, firstSnap: firstSnap)
                self.lastChild = snap.key
                
                if observeIterNum == loadNum {
                    DispatchQueue.main.async(execute: {
                        //                    self.chatTableView.reloadData()
                        self.addButtons(numOfUser: self.users.count)
                    })
                }
                firstSnap = false
                observeIterNum = observeIterNum + 1
                query.removeAllObservers()
            })
        }
    }
    
    func addToUsersArray(snapshot: DataSnapshot, firstUpdate: Bool, firstSnap: Bool) {
        let code = snapshot.key
        if firstUpdate {
            let dic = snapshot.value as? [String: Any]
            let user = User(code: code)
            user.settingFromDic(dic: dic)
            users.append(user)
        } else {
            if firstSnap == false {
                let dic = snapshot.value as? [String: Any]
                let user = User(code: code)
                user.settingFromDic(dic: dic)
                users.append(user)
            }
        }
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
//        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
        self.present(loginViewController, animated: false, completion: nil)
//        UserSetting.destroy()
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
    }

    
    


}
