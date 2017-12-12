//
//  MapService.swift
//  WedeChurchIOS
//
//  Created by Buty on 12/12/17.
//  Copyright © 2017 GCME. All rights reserved.
//

import MapKit
import AddressBook
import SwiftyJSON
import Contacts

class MapService: NSObject, MKAnnotation
{
    let title: String?
    let locationName: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String?, coordinate: CLLocationCoordinate2D)
    {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
    
    class func from(json: JSON) -> MapService?
    {
        var title: String
        if let unwrappedTitle = json["name"].string {
            title = unwrappedTitle
        } else {
            title = ""
        }
        
        let locationName = json["address"]["city"].string
        let lat = json["address"]["geo"]["lat"].doubleValue
        let long = json["address"]["geo"]["lng"].doubleValue
        print("loc\(String(describing: locationName))")
        
        //        var locationName = json["location"]["address"].string!
        //        locationName += ", "
        //        locationName += json["location"]["city"].string!
        //        locationName += ", "
        //        locationName += json["location"]["state"].string!
        //        locationName += " "
        //        locationName += json["location"]["postalCode"].string!
        //
        //        let lat = json["location"]["lat"].doubleValue
        //        let long = json["location"]["lng"].doubleValue
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        
        return MapService(title: title, locationName: locationName, coordinate: coordinate)
    }
    
    func mapItem() -> MKMapItem
    {
        let addressDictionary = [CNPostalAddressStreetKey : subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)
        let mapItem = MKMapItem(placemark: placemark)
        
        mapItem.name = "\(String(describing: title)) \(String(describing: subtitle))"
        
        return mapItem
    }
}













