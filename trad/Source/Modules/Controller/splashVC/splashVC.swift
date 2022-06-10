//
//  splashVC.swift
//  trad
//
//  Created by Imac on 10/05/21.
//

import UIKit

class splashVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let storyboard: UIStoryboard = self.storyboard!
            let controller = storyboard.instantiateViewController(withIdentifier: "MainTabBarController")
            self.navigationController?.pushViewController(controller, animated:    true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }     
}
