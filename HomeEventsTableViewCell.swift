//
//  HomeEventsTableViewCell.swift
//  WedeChurchIOS
//
//  Created by Muluken on 7/12/17.
//  Copyright © 2017 GCME. All rights reserved.
//

import UIKit

class HomeEventsTableViewCell: UITableViewCell {

    @IBOutlet weak var homeEventImage: UIImageView!
    @IBOutlet weak var homeEventLoc: UILabel!
    @IBOutlet weak var homeEventTime: UILabel!
    @IBOutlet weak var homeEventName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
