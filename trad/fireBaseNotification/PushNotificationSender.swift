//
//  PushNotificationSender.swift
//  Journey App
//
//  Created by Zeroit on 11/12/19.
//  Copyright © 2019 Zero ITSolutions. All rights reserved.
//  https://www.iosapptemplates.com/blog/ios-development/push-notifications-firebase-swift-5


import UIKit

class PushNotificationSender {
    
    let serverKey = "AAAAfVeZuKE:APA91bHoIh4PL6tUSOCWNPXGOKa8d2OcbK2POeR2SnLekV5wr8S_6srwF51A7rYEaay4f_2EZzS_eSRzPmwgJUf4ai2dBXiw7xDVGI62BEl7B3-QAaM_d0oR7QKy73Regk5Y-nfpXLAT"
    
    func sendPushNotification(to token: String, title: String, body: String) {
        let urlString = "https://fcm.googleapis.com/fcm/send"
        let url = NSURL(string: urlString)!
        let paramString: [String : Any] = ["to" : token,
                                           "notification" : ["title" : title,
                                                             "body" : body,
                                                             "sound":"default"],
                                           "data" : ["user" : "test_id"],
                                           "sound":"default"
        ]
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject:paramString, options: [.prettyPrinted])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("key=\(serverKey)", forHTTPHeaderField: "Authorization")
        let task =  URLSession.shared.dataTask(with: request as URLRequest)  { (data, response, error) in
            do {
                if let jsonData = data {
                    if let jsonDataDict  = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject] {
                        NSLog("Received data:\n\(jsonDataDict))")
                    }
                }
            } catch let err as NSError {
                print(err.debugDescription)
            }
        }
        task.resume()
    }
}

