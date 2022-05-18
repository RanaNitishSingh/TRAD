//
//  markerWindow.swift
//  trad
//
//  Created by Imac on 29/06/21.
//

import UIKit

class markerWindow: UIView {
    
    @IBOutlet var infoWindowTableView: UITableView!
    
    func loadview() -> markerWindow{
       
        let markerWindow = Bundle.main.loadNibNamed("markerwindow", owner: self, options: nil)?[0] as! markerWindow
        let frame = CGRect(x: 10, y: 10, width: 360, height: 200)
        markerWindow.frame = frame
        return markerWindow
    }
}
