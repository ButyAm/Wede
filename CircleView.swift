//
//  CircleView.swift
//  devslopes-social
//
//  Created by Jess Rascal on 24/07/2016.
//  Copyright © 2016 JustOneJess. All rights reserved.
//

import UIKit

class CircleView: UIImageView {

    override func layoutSubviews() {
        layer.cornerRadius = self.frame.width / 2
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 1.0).cgColor
        
        layer.borderColor = UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0).cgColor
        layer.borderWidth = 4.0
        clipsToBounds = true
    }
}
