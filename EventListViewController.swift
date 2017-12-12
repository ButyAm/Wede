//
//  EventListViewController.swift
//  WedeChurchIOS
//
//  Created by Muluken on 6/7/17.
//  Copyright © 2017 GCME. All rights reserved.
//

import UIKit
import SystemConfiguration
import MBProgressHUD
import Alamofire
import SDWebImage

class EventListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var menuBar: UIBarButtonItem!
    // outlet - search bar
    @IBOutlet var mySearchBar: UISearchBar!
    
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
    
    var selectedImage:String?
    var selectedTitle:String?
    var selectedDesc:String?
    var selectedTime:String?
    var selectedUrl:String?
    
    
    
    var eventListImages: [String] = [String]()
    
    // array of event list
    var eventListName: [String] = [String]()
    var eventNameSearching: [String] = [String]()
    
    // search in progress or not
    var isSearching : Bool = false
    
    // sending images to detail event view
    var nameEvent: AnyObject? {
        
        get {
            return UserDefaults.standard.object(forKey: "eventListName") as AnyObject?
        }
        set {
            UserDefaults.standard.set(newValue!, forKey: "eventListName")
            UserDefaults.standard.synchronize()
        }
    }
    var imageEvent: AnyObject? {
        
        get {
            return UserDefaults.standard.object(forKey: "eventListImage") as AnyObject?
        }
        set {
            UserDefaults.standard.set(newValue!, forKey: "eventListImage")
            UserDefaults.standard.synchronize()
        }
    }
    
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
                // print("internet available")
                self.getDataFromServer()
            }else{
                print("internet not available")
                // self.fetchDataFromDB()
            }
        }
        
    }
    
    
    
    
    //MARK: - view functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //reveal navigation controller
        if revealViewController() != nil {
            
            menuBar.target = revealViewController()
            menuBar.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
        
        
        
        // set table view delegate
        self.myTableView.dataSource = self
        self.myTableView.delegate = self
        
        // set search bar delegate
        self.mySearchBar.delegate = self
    }
    
    func getServerData() {
        let params = ["service": "event_get"] as [String : Any]
        
        let apiMethod = "http://wede.myims.org/api" //<-Set your endpoint here
        
        Alamofire.request(apiMethod, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON(completionHandler: {
            response in
            switch response.result {
            case .success:
                print("response is:" ,response)
                print("")
                if let dict = response.result.value as? [String : AnyObject], let list = dict["response"] as? [[String : AnyObject]] {
                    self.listData = list
                    print(self.listData)
                }
                
            case .failure(let error):
                print(error)
            }
        })
        
    }
    
    func getDataFromServer(){
       //   self.showMBProgressHUD()
        
        
        let parameters = ["service": "event_get" , "param": ""]
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
                            for events in eventArray{
                                if let eventsDict = events as? NSDictionary {
                                    if let name = eventsDict.value(forKey: "name") {
                                        self.nameArray.append(name as! String)
                                        //print(self.nameArray)
                                    }
                                    //                                    if let name = actorDict.value(forKey: "dob") {
                                    //                                        self.dobArray.append(name as! String)
                                    //                                    }
                                    if let eventImageOne = eventsDict.value(forKey: "banner") {
                                        self.imageURL.append(eventImageOne as! String)
                                        // print(self.imageURL)
                                    }
                                    if let eventLoc = eventsDict.value(forKey: "location") {
                                        self.location.append(eventLoc as! String)
                                    }
                                    if let eventLat = eventsDict.value(forKey: "latitude") {
                                        self.latitude.append(eventLat as! String)
                                    }
                                    let eventLong = eventsDict.value(forKey: "longitude") as AnyObject
                                    self.longitude.append(eventLong as! String)
                                    
                                    
                                    if let eventContactInfo = eventsDict.value(forKey: "contact_info") {
                                        self.contactInfo.append(eventContactInfo as! String)
                                    }
                                    if let eventDesc = eventsDict.value(forKey: "description") {
                                        self.eventDescription.append(eventDesc as! String)
                                    }
                                    
                                    
                                }
                                
                                if let secondResponse = events as? NSDictionary {
                                    
                                    if let createdDate = secondResponse["created_date"] as? NSDictionary
                                    {
                                        let eventDate = createdDate.value(forKey: "date") as? String
                                        self.eventWebDate.append(eventDate!)
                                        
                                    }
                                    
                                    
                                    
                                }
                                // event linked church id
                                if let thirdResponse = events as? NSDictionary {
                                    
                                    if let churchId = thirdResponse["church_id"] as? NSDictionary
                                    {
                                        let eventChurchId = churchId.value(forKey: "name") as? String
                                        print(eventChurchId as AnyObject)
                                        
                                    }
                                    
                                    
                                    
                                }
                                
                                
                                
                                
                            }
                        }
                        
                        OperationQueue.main.addOperation({
                            self.myTableView.reloadData()
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
               return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! EventListTableViewCell
        if isInternetAvailable(){
            
            
            cell.eventTitle.text = nameArray[indexPath.row]
            cell.eventTime.text = eventWebDate[indexPath.row]
            cell.eventImage.sd_setImage(with: URL(string: imageURL[indexPath.row]), placeholderImage: #imageLiteral(resourceName: "Wedechurch-Icon"))
                    }
        else {
            cell.eventImage.image = UIImage(named: "yougo")!
            cell.eventTitle.text = "There is no data"
            
        }
        
        return cell
    }
    
    ///for showing next detailed screen with the downloaded info
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "EventDetailViewController") as! EventDetailViewController
        vc.imageString = imageURL[indexPath.row]
        vc.nameString = nameArray[indexPath.row]
        vc.locationString = location[indexPath.row]
        vc.longitudeString = longitude[indexPath.row]
        vc.latitudeString = latitude[indexPath.row]
        vc.contactString = contactInfo[indexPath.row]
        vc.descriptionString = eventDescription[indexPath.row]
        vc.dateString = eventWebDate[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
    // MARK: - UISearchBar delegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if self.mySearchBar.text!.isEmpty {
            
            // set searching false
            self.isSearching = false
            
            // reload table view
            self.myTableView.reloadData()
            
        }else{
            
            // set searghing true
            self.isSearching = true
            
            // empty searching array
            self.eventNameSearching.removeAll(keepingCapacity: false)
            
            // find matching item and add it to the searcing array
            for i in 0..<self.eventListName.count {
                
                let listItem : String = self.eventListName[i]
                if listItem.lowercased().range(of: self.mySearchBar.text!.lowercased()) != nil {
                    self.eventNameSearching.append(listItem)
                }
            }
            
            self.myTableView.reloadData()
        }
        
    }
    
    // hide kwyboard when search button clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.mySearchBar.resignFirstResponder()
    }
    
    // hide keyboard when cancel button clicked
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.mySearchBar.text = ""
        self.mySearchBar.resignFirstResponder()
        
        self.myTableView.reloadData()
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

