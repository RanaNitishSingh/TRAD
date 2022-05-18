//
//  BaseTabBarController.swift
//  trad
//
//  Created by Imac on 16/06/21.
//

import Foundation
import UIKit
import FirebaseFirestore
import FirebaseAuth

class BaseTabBarController: UITabBarController,UITabBarControllerDelegate {

    @IBInspectable var defaultIndex: Int = 0
    var viewControllerList: [UIViewController]?
    var User = ""
    var Email = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedIndex = defaultIndex
       
        DispatchQueue.main.async(execute: getUserTab)
    }
    
    func getUserTab() {
          //Get specific document from current user
          let dataBase = Firestore.firestore()
              .collection("Users")
              .document(Auth.auth().currentUser?.uid ?? "")

          // Get data
        dataBase.getDocument { (document, error) in
              guard let document = document, document.exists else {
                  print("Document does not exist")
                  return
              }
              let tabUserData = document.data()
            self.User = tabUserData?["UserType"] as! String
            self.Email = tabUserData?["Email"] as! String
            
          
            
           if self.User != "Admin" {
             
               self.viewControllers = [self.viewControllers![0], self.viewControllers![1], self.viewControllers![3]]
           }else{
               
               self.viewControllers = [self.viewControllers![0], self.viewControllers![1], self.viewControllers![2],self.viewControllers![3]]
              
           }}
      }

    
    
    
    
   
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
            if let index = tabBar.items?.firstIndex(of: item) {
                if let count = viewControllers?.count, count > 5, index == 4 {
                    DispatchQueue.main.async {
                        self.moreNavigationController.popToRootViewController(animated: false)
                    }
                } else if let vcs = viewControllers, let vc = vcs[index] as? UINavigationController {
                    DispatchQueue.main.async {
                        vc.popToRootViewController(animated: false)
                    }
                }
            }
        }
   
    
    
//    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//            if let navigationController = viewController as? UINavigationController,
//                navigationController.viewControllers.contains(where: { $0 is ViewController }) {
//                //show pop up view
//                return false
//            } else  {
//                return true
//            }
//        }
//
    
}
