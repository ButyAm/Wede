//
//  HomeEventsTableVC.swift
//  WedeChurchIOS
//
//  Created by Muluken on 7/12/17.
//  Copyright © 2017 GCME. All rights reserved.
//

import UIKit
import SystemConfiguration
import MBProgressHUD
import Alamofire
import SDWebImage

class HomeEventsTableVC: UITableViewController {
    
    var partialView: CGFloat {
        return UIScreen.main.bounds.height - 150
    }
    var fullView: CGFloat = 150
    
    // outlet - table view
    @IBOutlet var myTableView: UITableView!
    
    var listData: [[String: AnyObject]] = [[String: AnyObject]]()
    
    var nameArray = [String]()
    var imageURL = [String]()
    var location = [String]()
    var latitude = [String]()
    var longitude = [String]()
    var contactInfo = [String]()
    var eventDescription = [String]()
    var eventWebDate = [String]()
    
    
    // var fetchResults = [NSManagedObject]()
    var dictResponse: NSDictionary = [:]
    var arrayData : [[String:AnyObject]] = []
    
    var username: NSString? = nil
    var password: NSString? = nil
    
    var tableHeight : CGFloat = 0
    
  
    
    
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //    lblNoData.isHidden = true
        // Show the navigation bar & tab bar on the this view controller
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.tabBarController?.tabBar.isHidden = false
        
        if UserDefaults.standard.value(forKey: "userPassword") != nil {
            //do something here if password exists
            if UserDefaults.standard.value(forKey: "userEmail") != nil{
                username = UserDefaults.standard.value(forKey: "userEmail") as! NSString?
            }else{
                username = UserDefaults.standard.value(forKey: "userName") as! NSString?
            }
            password = UserDefaults.standard.value(forKey: "userPassword") as! NSString?
            // country = UserDefaults.standard.value(forKey: "country") as! NSString?
            
            if isInternetAvailable() {
                 print("internet available")
               // self.getDataFromServer()
            }else{
                print("internet not available")
                // self.fetchDataFromDB()
            }
        }
        
    }
    
    
    
    
    //MARK: - view functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //bottomsheetview controller click functioin
        addGestureForBottomAnimation()
        getDataFromServer()
          }
    
    override func viewDidAppear(_ animated: Bool) {
        animateAfterViewAppear()
    }

    func getDataFromServer(){
        //   self.showMBProgressHUD()
        
        
        let parameters = ["service": "church_get" , "param": ""]
        let url = URL(string: "http://wede.myims.org/api")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        request.httpBody = httpBody
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                //  self.hideMBProgressHUD()
                do {
                    //   print("in")
                    if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary {
                        // print(jsonObj as AnyObject)
                        
                        if let eventArray = jsonObj!.value(forKey: "response") as? NSArray {
                            print(eventArray)
                            for events in eventArray{
                                if let eventsDict = events as? NSDictionary {
                                    if let name = eventsDict.value(forKey: "name") {
                                        self.nameArray.append(name as! String)
                                        
                                    }
                                    
                                    if let eventImageOne = eventsDict.value(forKey: "banner") {
                                        self.imageURL.append(eventImageOne as! String)
                                        print(self.imageURL)
                                    }
                                    if let eventLoc = eventsDict.value(forKey: "location") {
                                        self.location.append(eventLoc as! String)
                                    }
                                    if let eventLat = eventsDict.value(forKey: "latitude") {
                                        self.latitude.append(eventLat as! String)
                                        print(self.latitude)
                                    }
                                    let eventLong = eventsDict.value(forKey: "longitude") as AnyObject
                                    self.longitude.append(eventLong as! String)
                                    print(self.longitude)
                                    
//
//                                    if let eventContactInfo = eventsDict.value(forKey: "contact_info") {
//                                        self.contactInfo.append(eventContactInfo as! String)
//                                    }
//                                    if let eventDesc = eventsDict.value(forKey: "description") {
//                                        self.eventDescription.append(eventDesc as! String)
//                                    }
                                    
                                    
                                }
                                
                                if let secondResponse = events as? NSDictionary {
                                    
                                    if let createdDate = secondResponse["created_date"] as? NSDictionary
                                    {
                                        let eventDate = createdDate.value(forKey: "date") as? String
                                        self.eventWebDate.append(eventDate!)
                                        
                                    }
                                    
                                    

                                }
                                // event linked church id
//                                if let thirdResponse = events as? NSDictionary {
//                                    
//                                    if let churchId = thirdResponse["church_id"] as? NSDictionary
//                                    {
//                                        let eventChurchId = churchId.value(forKey: "name") as? String
//                                        print(eventChurchId as AnyObject)
//                                        
//                                    }
//                                    
//                                    
//                                    
//                                }
//                                
                                
                                
                                
                            }
                        }
                        
                        OperationQueue.main.addOperation({
                            self.tableView.reloadData()
                        })
                    }
                    
                    
                }
                
            }
            
            }.resume()
        
    }
    
    func showMBProgressHUD() {
        let hud = MBProgressHUD.showAdded(to: (self.tabBarController?.view)!, animated: true)
        hud.mode = MBProgressHUDMode.indeterminate
        hud.label.text = "Loading..."
    }
    
    func hideMBProgressHUD() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: (self.tabBarController?.view)!, animated: true)
        }
    }
    
    //wede church alert
    func displayMyAlertMessage(userMessage:String)
    {
        
        let myAlert = UIAlertController(title:"WedeChurch Alert", message:userMessage, preferredStyle: UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.default, handler:nil);
        
        myAlert.addAction(okAction);
        
        self.present(myAlert, animated:true, completion:nil);
        
    }
    
    // MARK: - table view data source and delegate
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeEvents", for: indexPath) as! HomeEventsTableViewCell
        if isInternetAvailable(){
            
            
            cell.homeEventName.text = nameArray[indexPath.row]
            cell.homeEventTime.text = eventWebDate[indexPath.row]
            cell.homeEventImage.sd_setImage(with: URL(string: imageURL[indexPath.row]), placeholderImage: #imageLiteral(resourceName: "Wedechurch-Icon"))
        }
        else {
            cell.homeEventImage.image = UIImage(named: "yougo")!
            cell.homeEventName.text = "There is no data"
            
        }
        
        return cell
    }
    
    ///for showing next detailed screen with the downloaded info
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeEventDetailVC") as! HomeEventDetailVC
        vc.imageString = imageURL[indexPath.row]
        vc.nameString = nameArray[indexPath.row]
//        vc.locationString = location[indexPath.row]
//        vc.longitudeString = longitude[indexPath.row]
//        vc.latitudeString = latitude[indexPath.row]
//        vc.contactString = contactInfo[indexPath.row]
//        vc.descriptionString = eventDescription[indexPath.row]
        vc.dateString = eventWebDate[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
 
    
    func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
}
extension HomeEventsTableVC:UIGestureRecognizerDelegate{
    func addGestureForBottomAnimation(){
        let swipedOnImage = UIPanGestureRecognizer(target: self, action: #selector(self.panGesture(recognizer:)))
        view.addGestureRecognizer(swipedOnImage)
        view.isUserInteractionEnabled = true
        swipedOnImage.delegate = self
    }
    
    //MARK:- Animate afterViewWill Appear
    func animateAfterViewAppear(){
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.8, options: .curveLinear, animations: {
            self.view.frame = CGRect(x: 0, y: self.fullView, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    
    //MARK:- animate by dragging view
    @objc func panGesture(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation( in: self.view)
        let velocity = recognizer.velocity(in: self.view)
        let y = self.view.frame.minY
        //translate y postion when drag within fullview to partial view
        if (y + translation.y >= fullView) && (y + translation.y <= partialView) {
            
            self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
            recognizer.setTranslation(CGPoint(x:0,y:0), in: self.view)
        }
        if recognizer.state == .ended {
            var duration =  velocity.y < 0 ? Double((y - fullView) / -velocity.y) : Double((partialView - y) / velocity.y )
            
            duration = duration > 1.5 ? 1 : duration
            UIView.animate(withDuration: duration, delay: 0.0, options: [.allowUserInteraction], animations: {
                if  velocity.y >= 0 {
                    self.view.frame = CGRect(x: 0, y: self.partialView, width: self.view.frame.width, height: self.view.frame.height)
                } else {
                    
                    self.view.frame = CGRect(x: 0, y: self.fullView, width: self.view.frame.width, height: self.view.frame.height)
                }
                
            }, completion: nil)
        }
    }
    
    
}



