//
//  ChurchListTableViewCell.swift
//  WedeChurchIOS
//
//  Created by Muluken on 6/7/17.
//  Copyright © 2017 GCME. All rights reserved.
//

import UIKit

class ChurchListTableViewCell: UITableViewCell {
    @IBOutlet weak var churchName: UILabel!

    @IBOutlet weak var churchLogo: UIImageView!
    @IBOutlet weak var chruchLocation: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
