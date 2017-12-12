//
//  FavChurchesTableViewCell.swift
//  WedeChurchIOS
//
//  Created by Muluken on 6/13/17.
//  Copyright © 2017 GCME. All rights reserved.
//

import UIKit

class FavChurchesTableViewCell: UITableViewCell {

    @IBOutlet weak var churchName: UILabel!
    @IBOutlet weak var churchLocation: UILabel!
    @IBOutlet weak var churchImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
