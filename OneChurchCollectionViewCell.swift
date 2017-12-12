//
//  OneChurchCollectionViewCell.swift
//  WedeChurchIOS
//
//  Created by Muluken on 6/8/17.
//  Copyright © 2017 GCME. All rights reserved.
//

import UIKit


class OneChurchCollectionViewCell: UICollectionViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBOutlet weak var churchEventImage: UIImageView!
   
    @IBOutlet weak var churchEventName: UILabel!
    
    public var indexPath:IndexPath!
    
    
}
