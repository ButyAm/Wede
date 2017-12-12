//
//  HomeChurchesTableViewCell.swift
//  WedeChurchIOS
//
//  Created by Muluken on 7/12/17.
//  Copyright © 2017 GCME. All rights reserved.
//

import UIKit

class HomeChurchesTableViewCell: UITableViewCell {
    @IBOutlet weak var homeChurchName: UILabel!

    @IBOutlet weak var homeChurchImage: UIImageView!
    @IBOutlet weak var homeChurchLoc: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
