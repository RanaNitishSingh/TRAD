//
//   UIAlertView.swift
//  trad
//
//  Created by Imac on 03/02/22.
//

import Foundation
import UIKit


class TRADSingleton: NSObject {
    
    static let sharedInstance = TRADSingleton()
    let appName = "TRAD"
    
    func showAlert(title: String, msg: String, VC: UIViewController, cancel_action: Bool) {
        let alert = UIAlertController.init(title: title, message: msg, preferredStyle: .alert)
        let OK_action = UIAlertAction.init(title: "OK".localizedStr(), style: .default)
        alert.addAction(OK_action)
        if cancel_action {
            let Cancel_action = UIAlertAction.init(title: "Cancel", style: .default)
            alert.addAction(Cancel_action)
        }
        VC.present(alert, animated: true, completion: nil)
    }
}

