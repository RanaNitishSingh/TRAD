//
//  loginViewController.swift
//  trad
//
//  Created by Imac on 10/05/21.
//

import UIKit
import FirebaseAuth
import NVActivityIndicatorView
import FirebaseFirestore
import FirebaseMessaging
import UserNotifications

class loginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var emailTextView: UITextField!
    @IBOutlet var passwordTextview: UITextField!
    @IBOutlet var LoginBtn: UIButton!
    @IBOutlet var welcome: UILabel!
    @IBOutlet var signIntoContinue: UILabel!
    @IBOutlet var forgotPassword: UILabel!
    var CountData : [UserData] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
      
        self.emailTextView.delegate = self
        self.passwordTextview.delegate = self
        LoginBtn.layer.cornerRadius = 24
        self.hideKeyboardWhenTappedAround()
        LoginBtn.setTitle("loginBtn".localizedStr(), for: .normal)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
        
        
        let loginDetails =  UserDefaults.standard.value(forKey: "user_Email")

        if  loginDetails != nil {

            emailTextView.text = UserDefaults.standard.value(forKey: "user_Email") as? String
            passwordTextview.text = UserDefaults.standard.value(forKey: "user_Password") as? String
            let storyboard: UIStoryboard = (self.storyboard!)
            let controller = storyboard.instantiateViewController(withIdentifier: "MainTabBarController")
            self.navigationController?.pushViewController(controller, animated: true)

        }
        
        
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
         self.view.frame.origin.y = -258 // Move view 150 points upward
    }

    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0 // Move view to original position
    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    @objc func hideKeyboardWhenTappedAround() {
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
        }
        @objc func dismissKeyboard() {
            view.endEditing(true)
        }
    
    @IBAction func LoginBtnAction(_ sender: Any) {
        Helper().showUniversalLoadingView(true)
        Auth.auth().signIn(withEmail: emailTextView.text!, password: passwordTextview.text!) { [weak self] authResult, error in
            if error != nil {
                TRADSingleton.sharedInstance.showAlert(title: "ERROR", msg: "Enter Vaild Email And Password".localizedStr(), VC: self!, cancel_action: false)
                Helper().showUniversalLoadingView(false)
                
                
                
            }else{
                
            UserDefaults.standard.set(self!.emailTextView.text!, forKey: "user_Email")
            UserDefaults.standard.set(self!.passwordTextview.text!, forKey: "user_Password")
            UserDefaults.standard.setValue(authResult?.user.uid ?? "", forKey: "loginUID")
                
                let userID = authResult?.user.uid
              //  print(userID!)
                
                let pushManager = PushNotificationManager(userID: userID!)
                    pushManager.registerForPushNotifications()
              
                let db = Firestore.firestore()
                let token = Messaging.messaging().fcmToken
                
                let CountData = ["deviceToken" : token ]
                
                    let UpdateRef =  db.collection("Users").document(UserDefaults.standard.value(forKey: "loginUID") as! String)
                        UpdateRef.updateData(CountData) { err in
                        if let err = err {
                            print("Error adding document: \(err)")
                            TRADSingleton.sharedInstance.showAlert(title: TRADSingleton.sharedInstance.appName, msg: "Please try again".localizedStr(), VC: self!, cancel_action: false)
                            
                        } else {
                          print("Document added with ID: \(UserDefaults.standard.value(forKey: "loginUID") as! String)")
                }
                
   }
 
            let storyboard: UIStoryboard = (self?.storyboard!)!
            let controller = storyboard.instantiateViewController(withIdentifier: "MainTabBarController")
            self?.navigationController?.pushViewController(controller, animated:    true)
           
                
          
            Helper().showUniversalLoadingView(false)
        }
        }
        
        
        
        
        
    }
    
    
    
   }


//it is long established fact that a reader will be distracted by the readable content of a page when looking at its layout.
struct UserData: Codable {
    
    let UserType : String
    let UserName : String
    let Email : String
    let AdminName : String
    let uid: String
    let masterUid: String
    let adminUid: String
    let propertyCount : Int
    var deviceToken : String
    let appLanguage : String
}
