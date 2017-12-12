//
//  FavoritesViewController.swift
//  WedeChurchIOS
//
//  Created by Muluken on 6/8/17.
//  Copyright © 2017 GCME. All rights reserved.
//

import UIKit

//class FavoritesViewController: UIViewController {
//    
//    @IBOutlet weak var favMenuBar: UIBarButtonItem!
//    @IBAction func favBtnSegment(_ sender: Any) {
//        favoritesTableView.reloadData()
//    }
//    @IBOutlet weak var favoritesSegmentControl: UISegmentedControl!
//   
//    // @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
//    @IBOutlet weak var favoritesTableView: UITableView!
//   
//    let ChurcheNames:[String] = ["Mekane Yesus","Hiwot birhan", "MKC"]
//    let EventNames:[String] = ["Yu go wroshp","bez prayer", "glorioous ruins"]
//    
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // navigation drawer in menu bars
//        if revealViewController() != nil {
//            
//            favMenuBar.target = revealViewController()
//            favMenuBar.action = #selector(SWRevealViewController.revealToggle(_:))
//            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
//            
//        }
//        favoritesTableView.reloadData()
//
//       // addGestureForBottomAnimation()
//    }
//    
////    override func viewWillAppear(_ animated: Bool) {
////        self.favoritesTableView.tableFooterView = UIView()
////        favoritesTableView.reloadData()
////    }
//    
//   
//}
////MARK:- Table View Datasource and delegate
//extension FavoritesViewController : UITableViewDataSource , UITableViewDelegate{
//    
//    
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
//        
//        var returnValue = 0
//        switch (favoritesSegmentControl.selectedSegmentIndex) {
//        case 0:
//            returnValue = ChurcheNames.count
//            break
//        case 1:
//            returnValue = EventNames.count
//            break
//        default:
//            break
//            
//        }
//        return returnValue
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let cell = self.favoritesTableView.dequeueReusableCell(withIdentifier: "favoritesCell", for: indexPath as IndexPath) as? FavoritesTableViewCell
//        switch (favoritesSegmentControl.selectedSegmentIndex) {
//        case 0:
//            cell?.title?.text = ChurcheNames[indexPath.row]
//            break
//        case 1:
//            cell?.title?.text = EventNames[indexPath.row]
//            break
//        default:
//            break
//            
//        }
//        
//        return cell!
//    }
//}
//
//
//
