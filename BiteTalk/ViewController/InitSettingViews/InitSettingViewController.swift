//
//  InitSettingViewController.swift
//  BiteTalk
//
//  Created by 신진욱 on 17/04/2018.
//  Copyright © 2018 신진욱. All rights reserved.
//

import UIKit

class InitSettingViewController: UIViewController {
    
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    var containerView: InitContainerViewController?
    var stage = 0
    let maxStage = 3 // num of stage is 4
    
    var nickname: String? {
        didSet {
            print("nickname is \(nickname)")
        }
    }
    var laguage: [String]?
    var toSay: String?
    var voice: URL?
    
    @IBOutlet weak var preButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView = childViewControllers[0] as? InitContainerViewController
        if stage == 0 {
            preButton.isHidden = true
        }
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func handlePrevious(_ sender: UIButton) {
        if stage != 0 {
            stage = stage - 1
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
        if stage != maxStage {
            stage = stage + 1
            containerView?.seg = stage
            if stage == maxStage {
                nextButton.setTitle("Done", for: .normal)
            }
        }
        if stage != 0 {
            preButton.isHidden = false
        }
        self.dismissKeyboard()
    }

}
