//
//  InitContainerViewController.swift
//  BiteTalk
//
//  Created by 신진욱 on 18/04/2018.
//  Copyright © 2018 신진욱. All rights reserved.
//

import UIKit

class InitContainerViewController: UIViewController {
    
    let stageName = ["initfirst", "initsecond", "initthird", "initforth"]
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    var seg: Int? {
        didSet {
            view.bringSubview(toFront: self.childViewControllers[seg!].view)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for num in 0 ..< stageName.count {
            addSubview(stage: num)
            view.bringSubview(toFront: self.childViewControllers[0].view)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addSubview(stage: Int) {
        let viewCont = storyBoard.instantiateViewController(withIdentifier: stageName[stage])
        addChildViewController(viewCont)
        viewCont.view.frame = CGRect(x: 0,y: 0, width: self.view.frame.width,height: self.view.frame.height)
        view.addSubview(viewCont.view)
    }
}
