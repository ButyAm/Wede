//
//  DenominationCollectionViewCell.swift
//  WedeChurchIOS
//
//  Created by Muluken on 6/7/17.
//  Copyright © 2017 GCME. All rights reserved.
//

import UIKit

protocol TapCellDelegatee:NSObjectProtocol{
    func buttonTapped(indexPath:IndexPath)
}

class DenominationCollectionViewCell: UICollectionViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBOutlet weak var denominationImage: UIImageView!
    @IBOutlet weak var topButton: UIButton!
    weak var delegate:TapCellDelegate?

    public var indexPath:IndexPath!

    @IBOutlet weak var deniminationName: UILabel!
    @IBAction func buttonTapped(_ sender: UIButton) {
        if let delegate = self.delegate{
            delegate.buttonTapped(indexPath: indexPath)
        }
    }
}
