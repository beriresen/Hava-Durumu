//
//  FeedCell.swift
//  Weather
//
//  Created by Berire Şen Ayvaz on 30.01.2023.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var lblMiniDay: UILabel!
    @IBOutlet weak var imgMini: UIImageView!
    @IBOutlet weak var lblMiniDegree: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
