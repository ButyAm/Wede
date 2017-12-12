//
//  HomeEventDetailVC.swift
//  WedeChurchIOS
//
//  Created by Xcode on 10/4/17.
//  Copyright © 2017 GCME. All rights reserved.
//

import UIKit
import MapKit

class HomeEventDetailVC: UIViewController {
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
        //change nav bar color
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.white
        nav?.backgroundColor = UIColor(red: 7.0/255.0, green: 180.0/255.0, blue: 177.0/255.0, alpha: 1.0)
        nav?.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.orange]

        updateUI()
        
        // Do any additional setup after loading the view.
    }
    
    func updateUI() {
        self.detaileventLabel.text = nameString
//        self.location.text = locationString
        self.endtime.text = dateString
//        self.detailEventView.text = descriptionString
        
        
        detailImage.sd_setImage(with: URL(string: imageString), placeholderImage: #imageLiteral(resourceName: "Wedechurch-Icon"), options: [.progressiveDownload])
        
        
    }
    @IBAction func eventLocClicked(_ sender: Any) {
//        let coordinate = CLLocationCoordinate2DMake(latitudeString, longitudeString)
//        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
//        mapItem.name = nameString
//        mapItem.openInMapsWithLaunchOptions([MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
//        
    }
    
}
