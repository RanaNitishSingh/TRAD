//
//  detailTableViewCell.swift
//  trad
//
//  Created by Imac on 10/05/21.
//

import UIKit

class detailTableViewCell: UITableViewCell {
    @IBOutlet weak var QuestionLBL: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var answerLBL: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
