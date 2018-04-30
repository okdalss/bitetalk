//
//  InitSettingViewController.swift
//  BiteTalk
//
//  Created by 신진욱 on 17/04/2018.
//  Copyright © 2018 신진욱. All rights reserved.
//

import UIKit
import Firebase

class InitSettingViewController: UIViewController {
    
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    var containerView: InitContainerViewController?
    var stage = 0
    let maxStage = 4 // num of stage is 5
    var nickname: String = ""
    var gender: Int?
    var laguage: [String]?
    var toSay: String?
    var voice: URL?
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var preButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    var userSetting: UserSetting?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView = childViewControllers[0] as? InitContainerViewController
        if stage == 0 {
            preButton.isHidden = true
        }
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        progress.progress = 0.2
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func handlePrevious(_ sender: UIButton) {
        if stage != 0 {
            stage = stage - 1
            progress.progress = progress.progress - 0.2
            containerView?.seg = stage
            if stage == maxStage-1 {
//                nextButton.isHidden = false
                nextButton.setTitle("Next", for: .normal)
            }
            if stage == 0 {
                preButton.isHidden = true
            }
        }
    }
    
    @IBAction func handleNext(_ sender: UIButton) {
        switch stage {
        case 0:
            if UserSetting.shared().nickname.count != 0 {
                stageControll()
            } else {
                alertControll(message: "Enter nickname")
            }
            self.dismissKeyboard()
        case 1:
            stageControll()
        case 2:
            if UserSetting.shared().language != nil {
                stageControll()
            } else {
                alertControll(message: "Add language")
            }
        case 3:
            if UserSetting.shared().toSay != nil {
                stageControll()
            } else {
                alertControll(message: "Say anything")
            }
        default:
            return
        }
    }
    
    func stageControll() {
        if stage != maxStage {
            stage = stage + 1
            progress.progress = progress.progress + 0.2
            containerView?.seg = stage
            if stage == maxStage {
                nextButton.setTitle("Done", for: .normal)
            }
        }
        if stage != 0 {
            preButton.isHidden = false
        }
    }
    
    func alertControll(message: String) {
        let alertCont = UIAlertController(title: message, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action) in
            return
        }
        alertCont.addAction(okAction)
        self.present(alertCont, animated: true, completion: nil)
    }

}
