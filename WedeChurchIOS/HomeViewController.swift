//
//  HomeViewController.swift
//  WedeChurchIOS
//
//  Created by Muluken on 3/29/17.
//  Copyright © 2017 GCME. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import SwiftyJSON

class HomeViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var mapView: MKMapView!
    
    
    // location managerer declaration
    var locationManager = CLLocationManager()
    
    var mapServices = [MapService]()
    
    @IBOutlet weak var buttonCar: UIButton!
    
    let baseURL = "https://api.myjson.com/bins/13772b"
    
    
    func fetchData()
    {
        
        // let fileName = Bundle.main.path(forResource: "Venues", ofType: "json")
        //  let filePath = URL(fileURLWithPath: fileName!)
        
        let filePath = URL(string: baseURL)
        
        
        var data: Data?
        do {
            data = try Data(contentsOf: filePath!, options: Data.ReadingOptions(rawValue: 0))
        } catch let error {
            data = nil
            print("Report error \(error.localizedDescription)")
        }
        
        if let jsonData = data {
            do {  let jsons = try JSON(data: jsonData).array!
            print(jsons)
                
                for json in jsons {
                    if let venue = MapService.from(json: json) {
                        
                        self.mapServices.append(venue)
                        print(venue)
                        
                        
                        
                    }
                }
            } catch let error {
                data = nil
                print(error.localizedDescription)
            }
           
        }
        
        //        if let jsonData = data {
        //            let json = JSON(data: jsonData)
        //            if let venueJSONs = json["response"]["venues"].array {
        //                for venueJSON in venueJSONs {
        //                    if let venue = MapService.from(json: venueJSON) {
        //                        self.mapServices.append(venue)
        //                    }
        //                }
        //            }
        //        }
    }
    
    var currentPlacemark: CLPlacemark?

    
    @IBAction func findMyLocation(_ sender: Any) {
        guard let currentPlacemark = currentPlacemark else {
            return
        }
        
        let directionRequest = MKDirectionsRequest()
        let destinationPlacemark = MKPlacemark(placemark: currentPlacemark)
        
        directionRequest.source = MKMapItem.forCurrentLocation()
        directionRequest.destination = MKMapItem(placemark: destinationPlacemark)
        directionRequest.transportType = .automobile
        
        // calculate the directions / route
        let directions = MKDirections(request: directionRequest)
        directions.calculate { (directionsResponse, error) in
            guard let directionsResponse = directionsResponse else {
                if let error = error {
                    print("error getting directions: \(error.localizedDescription)")
                }
                return
            }
            
            let route = directionsResponse.routes[0]
            self.mapView.removeOverlays(self.mapView.overlays)
            self.mapView.add(route.polyline, level: .aboveRoads)
            
            let routeRect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegionForMapRect(routeRect), animated: true)
        }

    }

//    //finding users current location
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
//    {
//        let location = locations[0]
//
//        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
//        let myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
//        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
//        mapView.setRegion(region, animated: true)
//
////        print(location.altitude)
////        print(location.speed)
////
//        self.mapView.showsUserLocation = true
//        manager.stopUpdatingLocation()
//    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //hide button
        buttonCar.isHidden = true
        //map delegates
        mapView.delegate = self
        fetchData()
        mapView.addAnnotations(mapServices)
        
        // show navigation bar always
        navigationController?.setNavigationBarHidden(false, animated: false)

        
        //adding bottomsheetcontroller
        bottomView()
        
       

        //slide menu of home viewcontroller
        if revealViewController() != nil {
           
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
            
            
            
        }
        // Do any additional setup after loading the view.
    }

    func bottomView(){
        
        let bottomVC = storyboard?.instantiateViewController(withIdentifier: "frequentBottomVC") as! HomeEventsTableVC
        
        bottomVC.view.frame = CGRect(x: 0, y: UIScreen.main.bounds.height , width: self.view.frame.width, height: self.view.frame.height)
        self.addChildViewController(bottomVC)
        self.view.addSubview(bottomVC.view)
        bottomVC.didMove(toParentViewController: self)
    }
    
    
    override func viewDidAppear(_ animated: Bool)
    {
       
        
//        let isUserLoggedIn = UserDefaults.standard.bool(forKey: "isUserLoggedIn");
//
//        if(!isUserLoggedIn)
//        {
//            self.performSegue(withIdentifier: "loginView", sender: self);
//        }
//
//        if (isUserLoggedIn) {
//
//        }
        
        displayWalkthroughs()
    }
    
    
    func displayWalkthroughs()
    {
        // check if walkthroughs have been shown
        let userDefaults = UserDefaults.standard
        let displayedWalkthrough = userDefaults.bool(forKey: "DisplayedWalkthrough")
        
        // if we haven't shown the walkthroughs, let's show them
        if !displayedWalkthrough {
            // instantiate neew PageVC via storyboard
            if let pageViewController = storyboard?.instantiateViewController(withIdentifier: "welcomeScreen") as? WelcomeViewController {
                self.present(pageViewController, animated: true, completion: nil)
            }
        }
        
        if displayedWalkthrough {
            checkLocationServiceAuthenticationStatus()
        }
    }
    
    private let regionRadius: CLLocationDistance = 3000 // 1km ~ 1 mile = 1.6km
    func zoomMapOn(location: CLLocation)
    {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    func checkLocationServiceAuthenticationStatus()
    {
        locationManager.delegate = self
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    


}

extension HomeViewController : CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let location = locations.last!
        self.mapView.showsUserLocation = true
        zoomMapOn(location: location)
    }
}

extension HomeViewController : MKMapViewDelegate
{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
    {
        if let annotation = annotation as? MapService {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
            }
            
            return view
        }
        
        return nil
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
    {
        if let location = view.annotation as? MapService {
            self.currentPlacemark = MKPlacemark(coordinate: location.coordinate)
            buttonCar.isHidden = false
            
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer
    {
        let renderer = MKPolylineRenderer(overlay: overlay)
        
        renderer.strokeColor = UIColor.orange
        renderer.lineWidth = 4.0
        
        return renderer
    }
}















