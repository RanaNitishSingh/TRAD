//
//  Switcher.swift
//  trad
//
//  Created by ZIT-12 on 29/03/22.
//

import Foundation
import UIKit

class Switcher {
    
    static func updateRootVC(){
           
           let status = UserDefaults.standard.bool(forKey: "user_Email")
           var rootVC : UIViewController?
          
               print(status)
           

           if(status == true){
               rootVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController") as! BaseTabBarController
           }else{
               rootVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
           }
           
           let appDelegate = UIApplication.shared.delegate as! AppDelegate
           appDelegate.window?.rootViewController = rootVC
           
       }

    
}
