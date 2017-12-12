//
//  phoneConstant.swift
//  WedeChurchIOS
//
//  Created by Muluken on 8/23/17.
//  Copyright © 2017 GCME. All rights reserved.
//

import UIKit

struct phoneConstant {
    //  Device IPHONE
    static let kIphone_4s : Bool =  (UIScreen.main.bounds.size.height == 480)
    static let kIphone_5 : Bool =  (UIScreen.main.bounds.size.height == 568)
    static let kIphone_6 : Bool =  (UIScreen.main.bounds.size.height == 667)
    static let kIphone_6_Plus : Bool =  (UIScreen.main.bounds.size.height == 736)
    
    
    static let deviceHeight = UIScreen.main.bounds.height
    static let deviceWidth = UIScreen.main.bounds.width
    static let statusBar = UIApplication.shared.statusBarFrame.size.height
    
    //   Constant Variable.
}
