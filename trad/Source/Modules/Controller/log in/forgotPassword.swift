//
//  forgotPassword.swift
//  trad
//
//  Created by ZIT-12 on 30/05/22.
//

import UIKit
import Firebase

class forgotPassword: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var sendBtn: UIButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
        self.addBackBtn(textColor: UIColor.black, title: "")
    }
    
    @objc func hideKeyboardWhenTappedAround() {
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
        }
        @objc func dismissKeyboard() {
            view.endEditing(true)
        }
    
    @objc func keyboardWillShow(sender: NSNotification) {
         self.view.frame.origin.y = -180 // Move view 150 points upward
    }

    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0 // Move view to original position
    }
    
    @IBAction func sendAction(_ sender: Any) {
        
        let auth = Auth.auth()
        
        auth.sendPasswordReset(withEmail: emailTxtField.text!) { (error) in
            if let error = error {
                TRADSingleton.sharedInstance.showAlert(title: "TRAD", msg: "Enter Vaild Email".localizedStr(), VC: self, cancel_action: false)
            }
            
            TRADSingleton.sharedInstance.showAlert(title: "TRAD", msg: "A password reset email has been sent!".localizedStr(), VC: self, cancel_action: false)
            self.navigationController?.popToRootViewController(animated: true)
       
        }
    }

        
    }
    
  
