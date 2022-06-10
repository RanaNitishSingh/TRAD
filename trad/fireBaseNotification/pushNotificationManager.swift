//
//  notification.swift
//  Journey App
//
//  Created by Zeroit on 11/12/19.
//  Copyright © 2019 Zero ITSolutions. All rights reserved.
//   https://www.iosapptemplates.com/blog/ios-development/push-notifications-firebase-swift-5

import Firebase
import FirebaseFirestore
import FirebaseMessaging
import UIKit
import UserNotifications

let gcmMessageIDKey =  "gcm.message_id"

class PushNotificationManager: NSObject, MessagingDelegate, UNUserNotificationCenterDelegate {
    
    let userID: String
    init(userID: String) {
        self.userID = userID
        super.init()
    }
    
    func registerForPushNotifications() {
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            // For iOS 10 data message (sent via FCM)
            Messaging.messaging().delegate = self
        }else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
        UIApplication.shared.registerForRemoteNotifications()
        updateFirestorePushTokenIfNeeded()
    }
    
    
    func updateFirestorePushTokenIfNeeded() {
        if let token = Messaging.messaging().fcmToken {
            let myUID = Auth.auth().currentUser?.uid
            let notificationRef = Database.database().reference().child("Tokens").child(myUID!)
            notificationRef.setValue(["token": token])
            print(token)
        }
    }
    
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print(remoteMessage.appData)
        
    }
    
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        
        print("Firebase registration token: \(String(describing: fcmToken))")
        let dataDict: [String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(
            name: Notification.Name("FCMToken"),
            object: nil,
            userInfo: dataDict
        )
        updateFirestorePushTokenIfNeeded()
    }
    
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions)
                                -> Void) {
        let userInfo = notification.request.content.userInfo
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        
        // ...
        // Print full message.
        print(userInfo)
        // Change this to your preferred presentation option
        completionHandler([[.alert, .sound]])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo
        // ...
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print full message.
        print(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
            UserDefaults.standard.set(messageID, forKey: "messageId")
            movetoNextVc()
        }
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print full message.
        print(userInfo)
        completionHandler()
    }
    
    
    private func movetoNextVc(){
        guard let window = UIApplication.shared.keyWindow else{return}
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let Vc = storyBoard.instantiateViewController(withIdentifier: "salepriceViewController")
        let nav = UINavigationController(rootViewController: Vc)
        window.rootViewController = nav
        window.makeKeyAndVisible()
    }
}

