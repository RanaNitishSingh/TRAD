//
//  ViewController.swift
//  trad
//
//  Created by Imac on 10/05/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var logo: UIImageView!
    @IBOutlet var tittle: UILabel!
    @IBOutlet var requestPropertyBtn: UIButton!
    @IBOutlet var loginBtn: UIButton!
    @IBOutlet var LblLanguage: UILabel!
    @IBOutlet weak var switchBtn: UISwitch!
    var show = Bool()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        requestPropertyBtn.layer.cornerRadius = 24
        loginBtn.layer.cornerRadius = 24
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        let loginDetails =  UserDefaults.standard.value(forKey: "user_Email")
        
        if  loginDetails != nil {
            UserDefaults.standard.value(forKey: "user_Email")
            UserDefaults.standard.value(forKey: "user_Password")
            let storyboard: UIStoryboard = (self.storyboard!)
            let controller = storyboard.instantiateViewController(withIdentifier: "MainTabBarController")
            self.navigationController?.pushViewController(controller, animated: true)
            
        }
        
        
        
        
        if L102Language.currentAppleLanguage() == "ar" { self.switchBtn.isOn = false
            switchBtn.setOn(false, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    @IBAction func requestPropertyAction(_ sender: Any) {
        
    }
    
    @IBAction func loginAction(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "loginViewController") as! loginViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func switchLanguage(_ sender: UISwitch) {
        if L102Language.currentAppleLanguage() == "en" {
            L102Language.setAppleLAnguageTo(lang: "ar")
            UserDefaults.standard.set(true, forKey: "switch")
            UserDefaults.standard.set("ar", forKey: "CurrentLanguage")
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            Bundle.setLanguage("ar");
            LocalizationSystem.sharedInstance.setLanguage(languageCode: "ar")
            show = false
            self.tittle.text = ("it is long established fact that a reader will be distracted by the readable content of a page when looking at its layout.".localizedStr())
            loginBtn.setTitle("loginBtn".localizedStr(), for: .normal)
            requestPropertyBtn.setTitle("Request property".localizedStr(), for: .normal)
            switchBtn.isOn = true
            switchBtn.setOn(true, animated: true)
            sender.isOn = true
            let  mainStory = UIStoryboard(name: "Main", bundle: nil)
            let search = mainStory.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            UIView.beginAnimations("animation", context: nil)
            UIView.setAnimationDuration(1.0)
            self.navigationController!.pushViewController(search, animated: false)
            UIView.setAnimationTransition(UIView.AnimationTransition.flipFromLeft, for: self.navigationController!.view, cache: false)
            UIView.commitAnimations()
            
        }else {
            
            var transition: UIView.AnimationOptions = .transitionFlipFromLeft
            L102Language.setAppleLAnguageTo(lang: "en")
            transition = .transitionFlipFromRight
            UserDefaults.standard.set(false, forKey: "switch")
            UserDefaults.standard.set("en", forKey: "CurrentLanguage")
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            Bundle.setLanguage("en")
            LocalizationSystem.sharedInstance.setLanguage(languageCode: "en")
            self.tittle.text = ("it is long established fact that a reader will be distracted by the readable content of a page when looking at its layout.".localizedStr())
            loginBtn.setTitle("loginBtn".localizedStr(), for: .normal)
            requestPropertyBtn.setTitle("Request property".localizedStr(), for: .normal)
            switchBtn.isOn = true
            switchBtn.setOn(true, animated: true)
            sender.isOn = true
            let  mainStory = UIStoryboard(name: "Main", bundle: nil)
            let search = mainStory.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            UIView.beginAnimations("animation", context: nil)
            UIView.setAnimationDuration(1.0)
            self.navigationController!.pushViewController(search, animated: false)
            UIView.setAnimationTransition(UIView.AnimationTransition.flipFromRight, for: self.navigationController!.view, cache: false)
            UIView.commitAnimations()
        }
        
    }
    
}

