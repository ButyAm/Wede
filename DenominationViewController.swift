//
//  DenominationViewController.swift
//  WedeChurchIOS
//
//  Created by Muluken on 6/7/17.
//  Copyright © 2017 GCME. All rights reserved.
//

import UIKit
import SystemConfiguration
import MBProgressHUD

private let itemsPerRow: CGFloat = 2
private let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)


class DenominationViewController:  UIViewController,UICollectionViewDataSource , UISearchBarDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var menuBar: UIBarButtonItem!
    
    @IBOutlet weak var denominationSearchBar: UISearchBar!
    
    var cellIdentifier = "denomCell"
    var numberOfItemsPerRow : Int = 2
  //  var denominationNames:[String]?
    var denominationLogoss:[String]?
    var dataSourceForSearchResult:[String]?
    var searchBarActive:Bool = false
    var searchBarBoundsY:CGFloat?
    var refreshControl:UIRefreshControl?
    
    //fetched denomination data
    var denominationArray = [String]()
    var denominationLogoArray = [String]()
    var denomIdArray = [Int]()
    var churchIdArray = [Int]()
    var churchNameArray = [String]()
    var churchLocArray = [String]()
    var churchPhoneArray = [String]()
    
    
    
    let cellImage = ["profile.png", "profile.png", "profile.png", "profile.png", "profile.png", "profile.png"]
    let celltitle = ["profile.png", "profile.png", "profile.png", "profile.png", "profile.png", "profile.png"]
    
    // sending denominationName to detail denomination Controller view
    var denominationName: AnyObject? {
        
        get {
            return UserDefaults.standard.object(forKey: "denominationName") as AnyObject?
        }
        set {
            UserDefaults.standard.set(newValue!, forKey: "denominationName")
            UserDefaults.standard.synchronize()
        }
    }
    //sending denomination logo to detail denomination view controller
    var denominationLogo: AnyObject? {
        
        get {
            return UserDefaults.standard.object(forKey: "denominationLogo") as AnyObject?
        }
        set {
            UserDefaults.standard.set(newValue!, forKey: "denominationLogo")
            UserDefaults.standard.synchronize()
        }
    }
//    // collection items size
//    var cellWidth:CGFloat{
//        return collectionView.frame.size.width/2
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // navigation drawer in menu bars
        if revealViewController() != nil {
            
            menuBar.target = revealViewController()
            menuBar.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
        
        // navigation controller items control
        // self.navigationController?.setNavigationBarHidden(true, animated: true)
        denominationSearchBar.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
//        self.denominationNames = ["Mekane Yesus" , "Mulu Wongel" , "Hiwot BIrhan" , "Church1","Beza International" , "Meserete Christos" , "Kale Hiwot" , "You Go" , "Bethel" , "Glorious"]
        self.denominationLogoss = ["church","mekane","yougo","church","mekane","yougo","church","mekane","yougo", "church","mekane","yougo"]
        self.dataSourceForSearchResult = [String]()
        //check internet and load denominations
        chkInternetAndLoadData()
        //hide keyboard
        self.hideKeyboardWhenTappedArnd()
        
    }
    
    
    //checkInternet to load data from server
    func chkInternetAndLoadData(){
        if isInternetAvailable(){
            getDataFromServer()
        } else {
            print("no internet")
        }
    }
    
    // MARK: Search
    func filterContentForSearchText(searchText:String){
        self.dataSourceForSearchResult = self.denominationArray.filter({ (text:String) -> Bool in
            return text.contains(searchText)
        })
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 0 {
            self.searchBarActive    = true
            self.filterContentForSearchText(searchText: searchText)
            self.collectionView?.reloadData()
        }else{
            self.searchBarActive = false
            self.collectionView?.reloadData()
        }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self .cancelSearching()
        self.collectionView?.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBarActive = true
        self.view.endEditing(true)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.denominationSearchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchBarActive = false
        self.denominationSearchBar.setShowsCancelButton(false, animated: false)
    }
    func cancelSearching(){
        self.searchBarActive = false
        self.denominationSearchBar.resignFirstResponder()
        self.denominationSearchBar.text = ""
    }
    
    
    // MARK: <UICollectionViewDataSource>
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! DenominationCollectionViewCell
        cell.indexPath = indexPath
        
        let defaults = UserDefaults.standard
        let denominationNameArray = defaults.object(forKey: "denomName") as? [String] ?? [String]()

        //  cell.topButton.backgroundColor = UIColor .blue
        // cell.topLabel.textColor = UIColor.blue
        cell.denominationImage.image = UIImage(named: (self.denominationLogoss![indexPath.row]))
           cell.deniminationName!.text = denominationNameArray[indexPath.row];
//        if (self.searchBarActive) {
//            cell.deniminationName!.text = self.dataSourceForSearchResult![indexPath.row];
//        }else{
//            cell.deniminationName!.text = self.denominationArray[indexPath.row];
//        }
//        cell.denominationImage.image = UIImage(named: cellImage[indexPath.row])
//        cell.deniminationName.text = celltitle[indexPath.row]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.searchBarActive {
            return self.dataSourceForSearchResult!.count;
        }
        return self.denominationArray.count
      //  return cellImage.count
    }
    
    
//    
//    // MARK: <UICollectionViewDelegateFlowLayout>
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
//        let totalSpace = flowLayout.sectionInset.left
//            + flowLayout.sectionInset.right
//            + (flowLayout.minimumInteritemSpacing * CGFloat(numberOfItemsPerRow - 1))
//        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(numberOfItemsPerRow))
//        return CGSize(width: size, height: size)
//    }
//    
//    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
//        return CGRect(x: x, y: y, width: width, height: height)
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //        denominationName = denominationArray [indexPath.row] as AnyObject?
        //        denominationLogo = denominationLogoArray [indexPath.row] as AnyObject?
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DenominationDetailView") as! DenominationDetailView
        
        if (denomIdArray == churchIdArray) {
            vc.churchLogoString = denominationLogoss![indexPath.row]
            vc.churchNameString = churchNameArray[indexPath.row]
            vc.denomNameString = denominationArray[indexPath.row]
            vc.churchLocString = churchLocArray[indexPath.row]
            vc.churchPhoneString = churchPhoneArray[indexPath.row]
            
        }
        
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func getDataFromServer(){
           self.showMBProgressHUD()
        
        
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
                  self.hideMBProgressHUD()
                do {
                    //   print("in")
                    if let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary {
                        // print(jsonObj as AnyObject)
                        
                        if let eventArray = jsonObj!.value(forKey: "response") as? NSArray {
                            for events in eventArray{
                                if let eventsDict = events as? NSDictionary {
                                    
                                    if let churchID = eventsDict.value(forKey: "id") {
                                        self.churchIdArray.append(churchID as! Int)

                                    }
                                    if let churchName = eventsDict.value(forKey: "name") {
                                        self.churchNameArray.append(churchName as! String)
                                        
                                    }
                                    if let churchLoc = eventsDict.value(forKey: "location") {
                                        self.churchLocArray.append(churchLoc as! String)
                                        
                                    }
                                    if let churchPhone = eventsDict.value(forKey: "Phone") {
                                        self.churchPhoneArray.append(churchPhone as! String)
                                        
                                    }
                                    //denomination details
                                    if let denomination = eventsDict.value(forKey: "denomination") {
                                        if let denomName = (denomination as AnyObject).value(forKey: "name") as? String {
                                          self.denominationArray.append(denomName)
                                            
                                            let denominationArray = UserDefaults.standard
                                            denominationArray.set(denomName, forKey: "denomName")
                                            
                                                                                   }
                                        if let denomId = (denomination as AnyObject).value(forKey: "id") as? Int {
                                            self.denomIdArray.append(denomId)
                                        }
                                        if let denominationLogos = (denomination as AnyObject).value(forKey: "banner") as? String {
                                            self.denominationLogoArray.append(denominationLogos)
                                            print(denominationLogos)
                                        }
                                        
                                  
                                    }
                                    
                  
                                }
                                
                       
                                
                                
                                
                            }
                        }
                        
                        OperationQueue.main.addOperation({
                            self.collectionView.reloadData()
                        })
                    }
                    
                    
                }
                
            }
            
            }.resume()
        
    }
    
    func showMBProgressHUD() {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = MBProgressHUDMode.indeterminate
        hud.label.text = "Loading..."
    }
    
    func hideMBProgressHUD() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
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

extension UIViewController {
    func hideKeyboardWhenTappedArnd() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKybrd))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKybrd() {
        view.endEditing(true)
    }
}
extension DenominationViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth /  itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
