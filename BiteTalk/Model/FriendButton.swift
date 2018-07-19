//
//  FriendButton.swift
//  BiteTalk
//
//  Created by 신진욱 on 17/07/2018.
//  Copyright © 2018 신진욱. All rights reserved.
//

import UIKit

class FriendButton: UIButton {

    override func draw(_ rect: CGRect) {
//        self.frame = CGRect(x: 160, y: 100, width: 50, height: 50)
        self.setTitle("invite friends", for: .normal)
        self.setTitleColor(UIColor.black, for: .normal)
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
        self.clipsToBounds = true
        self.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
    }
    

}
