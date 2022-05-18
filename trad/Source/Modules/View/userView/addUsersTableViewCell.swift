//
//  addUsersTableViewCell.swift
//  trad
//
//  Created by zeroit01 on 13/09/21.
//

import UIKit

class addUsersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userNameCellLBL: UILabel!
    @IBOutlet var userTypeLbl: UILabel!
    @IBOutlet var userAdminLbl: UILabel!
    
}
class AdminTableViewCell: UITableViewCell {
    
    @IBOutlet weak var AdminNameTableCellLBL: UILabel!
}

//MARK:- Alert Public Class 
extension UIViewController {
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "TRAD" , message:
                                                    message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: {action in
        }))
        self.present(alertController, animated: true, completion: nil)
    }
}
