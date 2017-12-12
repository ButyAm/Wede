//
//  EventDetailViewController.swift
//  WedeChurchIOS
//
//  Created by Muluken on 5/9/17.
//  Copyright © 2017 GCME. All rights reserved.
//

import UIKit
import SDWebImage

class EventDetailViewController: UIViewController {
    @IBOutlet weak var detailImage: UIImageView!

    @IBOutlet weak var detailEventView: UITextView!
    @IBOutlet weak var detaileventLabel: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var endtime: UILabel!
    @IBOutlet weak var category: UILabel!
    
    //data from previous controller
    var nameString:String!
    var imageString:String!
    var locationString:String!
    var longitudeString:String!
    var latitudeString:String!
    var contactString:String!
    var descriptionString:String!
    var dateString:String!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
       updateUI()
        
        // Do any additional setup after loading the view.
    }

    func updateUI() {
        self.detaileventLabel.text = nameString
        self.location.text = locationString
        self.endtime.text = dateString
        self.detailEventView.text = descriptionString
        
        
        detailImage.sd_setImage(with: URL(string: imageString), placeholderImage: #imageLiteral(resourceName: "Wedechurch-Icon"), options: [.progressiveDownload])
        

    }

}
