//
//  AppDelegate.swift
//  trad
//
//  Created by Imac on 10/05/21.
//

import UIKit
import CoreData
import Firebase
import GoogleMaps
import GooglePlaces
import UserNotifications
import FirebaseInstanceID
import FirebaseMessaging

let appDelegate = UIApplication.shared.delegate as! AppDelegate


let googleApiKey = "AIzaSyDrpoJE-FXgMvHJx3Bw0rNNIXez2IGYyN8"
//"AIzaSyB3bA7SKc32GplyHR5RZjFJTUxNIW4mBmo".
//let googlePlaceApiKey = "AIzaSyBrNRrOgDJnokCGOsvTyC556MLJaLJQPsI"


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure() 
        GMSServices.provideAPIKey(googleApiKey)
        GMSPlacesClient.provideAPIKey(googleApiKey)
        
        //        if UserDefaults.standard.bool(forKey: "LOGINSESSION"){
        //
        //            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        //            let newViewController = storyBoard.instantiateViewController(withIdentifier: "MainTabBarController") as! BaseTabBarController
        //            let navigationController = UINavigationController(rootViewController: newViewController)
        //            navigationController.navigationBar.isHidden = true
        //
        //            UIApplication.shared.windows.first?.rootViewController = navigationController
        //            UIApplication.shared.windows.first?.makeKeyAndVisible()
        
        let uid = UserDefaults.standard.string(forKey: "MyUID") ?? "nil"
        let pushManager = PushNotificationManager(userID: "\(uid)")
        pushManager.registerForPushNotifications()
        //     }
        return true
    }
    
    
    
    
    // MARK: UISceneSession Lifecycle
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("fail to register with push notification")
    }
    
}

