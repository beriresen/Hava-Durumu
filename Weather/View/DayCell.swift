//
//  DayCell.swift
//  Weather
//
//  Created by Berire Şen Ayvaz on 27.01.2023.
//

import UIKit

class DayCell: UITableViewCell {

    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var lblDegree: UILabel!
    @IBOutlet weak var imgDay: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
