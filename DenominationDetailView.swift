//
//  DenominationDetailView.swift
//  WedeChurchIOS
//
//  Created by Muluken on 6/7/17.
//  Copyright © 2017 GCME. All rights reserved.
//

import UIKit

class DenominationDetailView: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    //outlet - denomination name
    @IBOutlet weak var denomPhone: UILabel!
    @IBOutlet weak var denomEmail: UILabel!

    @IBOutlet weak var detailDenominationName: UILabel!
    //outlet - denomination image
    @IBOutlet weak var detailDenominationLogo: UIImageView!
    // outlet - search bar
    @IBOutlet var mySearchBar: UISearchBar!
    
    // outlet - table view
    @IBOutlet var myTableView: UITableView!
    
    var denominationListImages: [String] = [String]()
    
    // array of denomination Name list
    var denominationListName: [String] = [String]()
    var denominationNameSearching: [String] = [String]()
   
    
    
    //data from previous controller
    var churchNameString:String!
    var churchLocString:String!
    var churchPhoneString:String!
    var churchLogoString:String!
    var denomNameString:String!
       
    // search in progress or not
    var isSearching : Bool = false
    
    // sending churchName to Churchlistdetail view controller
    var churchListName: AnyObject? {
        
        get {
            return UserDefaults.standard.object(forKey: "churchName") as AnyObject?
        }
        set {
            UserDefaults.standard.set(newValue!, forKey: "churchName")
            UserDefaults.standard.synchronize()
        }
    }
      // sending churchlogos to Churchlistdetail view controller
    var churchListImage: AnyObject? {
        
        get {
            return UserDefaults.standard.object(forKey: "churchImage") as AnyObject?
        }
        set {
            UserDefaults.standard.set(newValue!, forKey: "churchImage")
            UserDefaults.standard.synchronize()
        }
    }
    
    
    //MARK: - view functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailDenominationName.text = denomNameString
        detailDenominationLogo.image = UIImage(named: churchLogoString!)

        
        
        // fill up data
        self.denominationListImages = ["church","mekane","yougo","church","mekane","yougo","church","mekane","yougo", "church","mekane","yougo","church","mekane","yougo","church","mekane","yougo","church","mekane","yougo", "church","mekane","yougo"]
        self.denominationListName  = [
            "Mekane Yesus" , "Mulu Wongel" , "Hiwot BIrhan" , "Glorious","Beza International" , "Meserete Christos" , "Kale Hiwot" , "You Go" , "Bethel" , "Glorious", "Mekane Yesus" , "Mulu Wongel" , "Hiwot BIrhan" , "Glorious","Beza International" , "Meserete Christos" , "Kale Hiwot" , "You Go" , "Bethel" , "Glorious","Mekane Yesus" , "Mulu Wongel" , "Hiwot BIrhan" , "Glorious"
        ]
        
        // set table view delegate
        self.myTableView.dataSource = self
        self.myTableView.delegate = self
        
        // set search bar delegate
        self.mySearchBar.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - table view data source and delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return denominationListName.count
//        if isSearching == true {
//            return denominationNameSearching.count
//        }else {
//            return denominationListName.count
//        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "churchList", for: indexPath) as! ChurchListTableViewCell
        cell.churchLogo.image = UIImage(named: denominationListImages[indexPath.row])!
        
        cell.churchName.text = churchNameString
        
//        if self.isSearching == true {
//            cell.churchName.text = self.denominationNameSearching[(indexPath as NSIndexPath).row]
//        }else {
//            cell.churchName.text = self.denominationListName[(indexPath as NSIndexPath).row]
//        }
//        
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        
        
        // cell.contentView.backgroundColor = UIColor.white
        
        //cell.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 1.0])
        // cell.layer.masksToBounds = false
       // cell.layer.cornerRadius = 15.0
        
        //            cell.layer.shadowOffset = CGSize(width: -1, height: 1)
        //            cell.layer.shadowOpacity = 0.5
        //cell.layer.shadowColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 1.0])
        
        
    }
    
    
    
   //  MARK: - UISearchBar delegate
    
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
            self.churchNameString.removeAll(keepingCapacity: false)
            
            // find matching item and add it to the searcing array
            for i in 0..<self.denominationListName.count {
                
                let listItem : String = self.denominationListName[i]
                if listItem.lowercased().range(of: self.mySearchBar.text!.lowercased()) != nil {
                    self.churchNameString.append(listItem)
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        churchListName = denominationListName [indexPath.row] as AnyObject?
        churchListImage = denominationListImages [indexPath.row] as AnyObject?
        
        
        
    }
    
    //add delegate method for pushing to new detail controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        
    }
    
    
    
}

