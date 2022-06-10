//
//  Extensions.swift
//  trad
//
//  Created by Imac on 10/05/21.
//

import Foundation
import UIKit

extension UIView
{
    
    func addShadow()
    {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 6
    }
    
    func createGradientLayer(myColor1: UIColor, myColor2: UIColor) {             
        var gradientLayer: CAGradientLayer!
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [myColor1, myColor2]
        self.layer.addSublayer(gradientLayer)
    }
}

func setRootViewController(viewController: UIViewController) {
    let navController = UINavigationController(rootViewController: viewController)
    navController.isNavigationBarHidden = true
    if #available(iOS 13.0, *) {
        if appDelegate.window == nil {
            //Create New Window here
            appDelegate.window = UIWindow.init(frame: UIScreen.main.bounds)
        }
    } else {
        // Fallback on earlier versions
    }
    UIApplication.shared.windows.first?.rootViewController = navController
    UIApplication.shared.windows.first?.makeKeyAndVisible()
}

func setTabBarController() {
    let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as! UITabBarController
    vc.tabBar.layer.cornerRadius = 24
    vc.tabBar.layer.masksToBounds = true
    vc.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    setRootViewController(viewController: vc)
}
