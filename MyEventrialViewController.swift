//
//  MyEventrialViewController.swift
//  WedeChurchIOS
//
//  Created by Muluken on 8/29/17.
//  Copyright © 2017 GCME. All rights reserved.
//

//import UIKit
//import SystemConfiguration
//import MBProgressHUD
//import Alamofire
//import SDWebImage
//
//class MyEventrialViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
//    
//    @IBOutlet weak var menuBar: UIBarButtonItem!
//    // outlet - search bar
//    @IBOutlet var mySearchBar: UISearchBar!
//    
//    // outlet - table view
//    @IBOutlet var myTableView: UITableView!
//    
//    var listData: [[String: AnyObject]] = [[String: AnyObject]]()
//    
//    var nameArray = [String]()
//    
//    
//    // var fetchResults = [NSManagedObject]()
//    var dictResponse: NSDictionary = [:]
//    var arrayData : [[String:AnyObject]] = []
//    
//    var username: NSString? = nil
//    var password: NSString? = nil
//    
//    var tableHeight : CGFloat = 0
//    
//    var selectedImage:String?
//    var selectedTitle:String?
//    var selectedDesc:String?
//    var selectedTime:String?
//    var selectedUrl:String?
//    
//    
//    
//    var eventListImages: [String] = [String]()
//    
//    // array of event list
//    var eventListName: [String] = [String]()
//    var eventNameSearching: [String] = [String]()
//    
//    // search in progress or not
//    var isSearching : Bool = false
//    
//    // sending images to detail event view
//    var nameEvent: AnyObject? {
//        
//        get {
//            return UserDefaults.standard.object(forKey: "eventListName") as AnyObject?
//        }
//        set {
//            UserDefaults.standard.set(newValue!, forKey: "eventListName")
//            UserDefaults.standard.synchronize()
//        }
//    }
//    var imageEvent: AnyObject? {
//        
//        get {
//            return UserDefaults.standard.object(forKey: "eventListImage") as AnyObject?
//        }
//        set {
//            UserDefaults.standard.set(newValue!, forKey: "eventListImage")
//            UserDefaults.standard.synchronize()
//        }
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        
//        //    lblNoData.isHidden = true
//        // Show the navigation bar & tab bar on the this view controller
//        self.navigationController?.setNavigationBarHidden(false, animated: true)
//        self.tabBarController?.tabBar.isHidden = false
//        
//        if UserDefaults.standard.value(forKey: "userPassword") != nil {
//            //do something here if password exists
//            if UserDefaults.standard.value(forKey: "userEmail") != nil{
//                username = UserDefaults.standard.value(forKey: "userEmail") as! NSString?
//            }else{
//                username = UserDefaults.standard.value(forKey: "userName") as! NSString?
//            }
//            password = UserDefaults.standard.value(forKey: "userPassword") as! NSString?
//            // country = UserDefaults.standard.value(forKey: "country") as! NSString?
//            
//            if isInternetAvailable() {
//                // print("internet available")
//                self.getDataFromServer()
//            }else{
//                print("internet not available")
//                // self.fetchDataFromDB()
//            }
//        }
//        
//    }
//    
//    
//    
//    
//    //MARK: - view functions
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        //reveal navigation controller
//        if revealViewController() != nil {
//            
//            menuBar.target = revealViewController()
//            menuBar.action = #selector(SWRevealViewController.revealToggle(_:))
//            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
//            
//        }
//        
//        
//        
//        // set table view delegate
//        self.myTableView.dataSource = self
//        self.myTableView.delegate = self
//        
//        // set search bar delegate
//        self.mySearchBar.delegate = self
//        self.myTableView.reloadData()
//    }
//    
//    func getServerData() {
//        let params = ["service": "event_get"] as [String : Any]
//        
//        let apiMethod = "http://wede.myims.org/api" //<-Set your endpoint here
//        
//        Alamofire.request(apiMethod, method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON(completionHandler: {
//            response in
//            switch response.result {
//            case .success:
//                print("response is:" ,response)
//                print("")
//                if let dict = response.result.value as? [String : AnyObject], let list = dict["response"] as? [[String : AnyObject]] {
//                    self.listData = list
//                    print(self.listData)
//                }
//                
//            case .failure(let error):
//                print(error)
//            }
//        })
//        
//    }
//    
//    func getDataFromServer(){
//        //  self.showMBProgressHUD()
//        
//        
//        let parameters = ["service": "event_get" , "param": ""]
//        let url = URL(string: "http://wede.myims.org/api")
//        var request = URLRequest(url: url!)
//        request.httpMethod = "POST"
//        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
//        let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
//        request.httpBody = httpBody
//        let session = URLSession.shared
//        session.dataTask(with: request) { (data, response, error) in
//            if let data = data {
//                // print(data)
//                do {
//                    //   print("in")
//                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) //because JSON data started with dictionary. Not an array
//                    //   print("json:",json)
//                    
//                    //  print((json as AnyObject).value(forKey: "response") as Any)
//                    if let responseBroadcast = (json as AnyObject).value(forKey: "response") as? NSArray {
//                        // print(broadcastResponse)
//                        for responseResult in responseBroadcast{
//                            if let firstResponse = responseResult as? NSDictionary {
//                                if let eventBanner = firstResponse.value(forKey: "banner") {
//                                    print("banner url is:",eventBanner)
//                                }
//                                //                                if let name = actorDict.value(forKey: "name") {
//                                //                                    self.nameArray.append(name as! String)
//                                //                                }
//                                
//                                if let eventName = firstResponse.value(forKey: "name") {
//                                    self.nameArray.append(eventName as! String)
//                                    print("event name is:",eventName)
//                                }
//                                if let eventLoc = firstResponse.value(forKey: "location") {
//                                    print("location is:",eventLoc)
//                                }
//                                if let eventLat = firstResponse.value(forKey: "latitude") {
//                                    print("latitude is:",eventLat)
//                                }
//                                let eventLong = firstResponse.value(forKey: "longitude") as AnyObject
//                                self.nameArray.append(eventLong as! String)
//                                print("name arrayy:", self.nameArray)
//                                
//                                
//                                if let eventContactInfo = firstResponse.value(forKey: "contact_info") {
//                                    print("Contact info is:",eventContactInfo)
//                                }
//                                if let eventDesc = firstResponse.value(forKey: "description") {
//                                    print("descrpitoin is:",eventDesc)
//                                }
//                                
//                                
//                                //                                let names = responseString["response"] as AnyObject
//                                //                                let actorArray = responseString.value(forKey: "company") as? AnyObject
//                                //                                print(names)
//                                
//                                
//                                
//                            }
//                            //event date
//                            if let secondResponse = responseResult as? NSDictionary {
//                                
//                                if let createdDate = secondResponse["created_date"] as? NSDictionary
//                                {
//                                    // print(Response)
//                                    let eventDate = createdDate.value(forKey: "date") as? String
//                                    print(eventDate as AnyObject)
//                                    
//                                }
//                                
//                                
//                                
//                            }
//                            // event linked church id
//                            if let thirdResponse = responseResult as? NSDictionary {
//                                
//                                if let churchId = thirdResponse["church_id"] as? NSDictionary
//                                {
//                                    // print(Response)
//                                    let eventChurchId = churchId.value(forKey: "name") as? String
//                                    print(eventChurchId as AnyObject)
//                                    
//                                }
//                                
//                                
//                                
//                            }
//                            
//                            
//                            
//                        }
//                    }
//                    
//                    
//                }
//                catch {
//                    print("error:", error.localizedDescription)
//                }
//            }
//            
//            }.resume()
//        
//    }
//    
//    func showMBProgressHUD() {
//        let hud = MBProgressHUD.showAdded(to: (self.tabBarController?.view)!, animated: true)
//        hud.mode = MBProgressHUDMode.indeterminate
//        hud.label.text = "Loading..."
//    }
//    
//    func hideMBProgressHUD() {
//        DispatchQueue.main.async {
//            MBProgressHUD.hide(for: (self.tabBarController?.view)!, animated: true)
//        }
//    }
//    
//    //wede church alert
//    func displayMyAlertMessage(userMessage:String)
//    {
//        
//        let myAlert = UIAlertController(title:"WedeChurch Alert", message:userMessage, preferredStyle: UIAlertControllerStyle.alert);
//        
//        let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.default, handler:nil);
//        
//        myAlert.addAction(okAction);
//        
//        self.present(myAlert, animated:true, completion:nil);
//        
//    }
//    
//    // MARK: - table view data source and delegate
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        //        if isSearching == true {
//        //            return eventNameSearching.count
//        //        }else {
//        //            return eventListName.count
//        //        }
//        
//        //        if (self.arrayData.count>0) {
//        //            return self.arrayData.count
//        //        }else{
//        //            return 0
//        //        }
//        return nameArray.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! EventListTableViewCell
//        if isInternetAvailable(){
//            
//            
//            cell.eventTitle.text = nameArray[indexPath.row]
//            // let item = self.nameArray[indexPath.row]
//            // cell.eventTitle.text = nameArray[indexPath.row]
//            cell.eventImage.image = UIImage(named: "yougo")!
//            //            cell.eventTitle.text = nameArray[indexPath.row]
//            
//            
//            //  cell.eventImage.sd_setImage(with: item["banner"] as! URL)
//            
//            
//            print("internet is available")
//        }
//        else {
//            cell.eventImage.image = UIImage(named: "yougo")!
//            cell.eventTitle.text = "There is no data"
//            
//            // cell.eventTitle.text = self.eventListName[(indexPath as NSIndexPath).row]
//            
//        }
//        
//        return cell
//    }
//    
//    
//    
//    
//    // MARK: - UISearchBar delegate
//    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        
//        if self.mySearchBar.text!.isEmpty {
//            
//            // set searching false
//            self.isSearching = false
//            
//            // reload table view
//            self.myTableView.reloadData()
//            
//        }else{
//            
//            // set searghing true
//            self.isSearching = true
//            
//            // empty searching array
//            self.eventNameSearching.removeAll(keepingCapacity: false)
//            
//            // find matching item and add it to the searcing array
//            for i in 0..<self.eventListName.count {
//                
//                let listItem : String = self.eventListName[i]
//                if listItem.lowercased().range(of: self.mySearchBar.text!.lowercased()) != nil {
//                    self.eventNameSearching.append(listItem)
//                }
//            }
//            
//            self.myTableView.reloadData()
//        }
//        
//    }
//    
//    // hide kwyboard when search button clicked
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        self.mySearchBar.resignFirstResponder()
//    }
//    
//    // hide keyboard when cancel button clicked
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        self.mySearchBar.text = ""
//        self.mySearchBar.resignFirstResponder()
//        
//        self.myTableView.reloadData()
//    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        if isInternetAvailable(){
//            nameEvent = eventListName[indexPath.row] as AnyObject?
//            imageEvent = eventListImages[indexPath.row] as AnyObject?
//        }
//        else {
//            print("internt  is not available")
//        }
//        
//        
//    }
//    
//    //add delegate method for pushing to new detail controller
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        
//        
//        
//    }
//    
//    func isInternetAvailable() -> Bool
//    {
//        var zeroAddress = sockaddr_in()
//        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
//        zeroAddress.sin_family = sa_family_t(AF_INET)
//        
//        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
//            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
//                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
//            }
//        }
//        
//        var flags = SCNetworkReachabilityFlags()
//        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
//            return false
//        }
//        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
//        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
//        return (isReachable && !needsConnection)
//    }
//    
//}
//
