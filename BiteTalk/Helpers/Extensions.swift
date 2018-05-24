//
//  Extensions.swift
//  BiteTalk
//
//  Created by 신진욱 on 24/04/2018.
//  Copyright © 2018 신진욱. All rights reserved.
//

import UIKit

extension UIViewController {
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func toTheView(viewName: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let newviewcont = storyboard.instantiateViewController(withIdentifier: viewName)
        print("go to \(viewName)")
        self.present(newviewcont, animated: false, completion: nil)
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
