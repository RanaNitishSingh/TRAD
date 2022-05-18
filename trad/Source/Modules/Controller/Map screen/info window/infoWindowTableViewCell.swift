//
//  infoWindowTableViewCell.swift
//  trad
//
//  Created by Imac on 30/06/21.
//

import UIKit

class infoWindowTableViewCell: UITableViewCell {

    @IBOutlet weak var houseImages: UIImageView!
    @IBOutlet weak var lblDays: UILabel!
    @IBOutlet weak var lblBuildingType: UILabel!
    @IBOutlet weak var bathTubIMG: UIImageView!
    @IBOutlet weak var LblSAR: UILabel!
    @IBOutlet weak var bookmarkIMG: UIImageView!
    @IBOutlet weak var bathroomTubLbl: UILabel!
    @IBOutlet weak var LblMeter: UILabel!  
    @IBOutlet weak var bedIMG: UIImageView!
    @IBOutlet weak var LblDescription: UILabel!
    @IBOutlet weak var bedroomLbl: UILabel!    
    @IBOutlet var purposeLbl: UILabel!
    
    @IBOutlet var descriptionView: UIView!
    @IBOutlet var streetView: UIView!
    @IBOutlet var widthLbl: UILabel!
    
    @IBOutlet var widthImg: UIImageView!
    @IBOutlet var streetImg: UIImageView!
    
    @IBOutlet var streetLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
