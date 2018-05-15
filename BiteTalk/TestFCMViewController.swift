//
//  TestFCMViewController.swift
//  BiteTalk
//
//  Created by 신진욱 on 10/05/2018.
//  Copyright © 2018 신진욱. All rights reserved.
//

import UIKit
import Firebase

class TestFCMViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func subscribeTopic() {
        Messaging.messaging().subscribe(toTopic: "/topics/testTP")
    }
    
    @IBAction func handleSubscribeTP(_ sender: UIButton) {
        subscribeTopic()
    }
    
    @IBAction func handleUnsubscribeTP(_ sender: UIButton) {
        Messaging.messaging().unsubscribe(fromTopic: "/topics/testTP")
    }
    
    
    func httpPOST() {
        let json: [String: Any] = [ "to" : "/topics/testTP",
                                    "priority" : "high",
                                    "notification" : [
                                        "body" : "This is a Firebase Cloud Messaging Topic Message!",
                                        "title" : "FCM Message",
            ]
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        
        let urlString = "https://fcm.googleapis.com/fcm/send"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("key=AAAA3rCqXMo:APA91bEGLEJ0AhgWdZetxx_wEL7tTHeDL-XXomdMxTUQLoMLubhP447DAgVDydOJ_Y7bOpI6Zz8eJdd46cTx2jPHZ--1LrPU09-XbaH7ILHCwmSc9kE8o7YPAyX9uJ-GCTQpKBw_EX3x", forHTTPHeaderField: "Authorization")
        
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data.")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJson = responseJSON as? [String: Any] {
                print("Next line is response")
                print(responseJson)
            } else {
                print("No response..")
            }
        }
        task.resume()
    }
    
    @IBAction func handleSend(_ sender: UIButton) {
        Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { (timer) in
            print("runnnnnnnnnnn~~~~~~~")
            self.httpPOST()
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
