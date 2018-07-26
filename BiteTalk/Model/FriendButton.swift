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
        self.setTitle("+", for: .normal)
        self.setTitleColor(UIColor.black, for: .normal)
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
        self.clipsToBounds = true
        self.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(FriendButton.Tap))  //Tap function will call when user tap on button
//        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(FriendButton.Long)) //Long function will call when user long press on button.
//        tapGesture.numberOfTapsRequired = 1
//        self.addGestureRecognizer(tapGesture)
//        self.addGestureRecognizer(longGesture)
        
    }
    
    @objc
    func Tap() {
        print("Tap happend")
    }
    
    @objc
    func Long() {
        print("Long press")
    }
    

}
