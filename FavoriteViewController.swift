//
//  FavoriteViewController.swift
//  WedeChurchIOS
//
//  Created by Muluken on 6/9/17.
//  Copyright © 2017 GCME. All rights reserved.
//

import UIKit

//class FavoriteViewController: UIViewController, UITableViewDataSource ,UITableViewDelegate {
//
//    @IBOutlet weak var segmentedControl: UISegmentedControl!
//    @IBOutlet weak var favTabelView: UITableView!
//    @IBAction func btnSegment(_ sender: Any) {
//     favTabelView.reloadData()
//    }
//    
//    @IBOutlet weak var menu: UIBarButtonItem!
//    let eventString: [String] = ["one", "two", "three", "four"]
//    let churchString: [String] = ["churhcone", "church two", "church three","church four"]
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        if revealViewController() != nil {
//            
//            menu.target = revealViewController()
//            menu.action = #selector(SWRevealViewController.revealToggle(_:))
//            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
//            
//        }
//        // Do any additional setup after loading the view.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        var returnValue = 0
//        switch (segmentedControl.selectedSegmentIndex){
//            case 0:
//                returnValue = eventString.count
//                break
//            case 1:
//                returnValue = churchString.count
//                break
//        default:
//            break
//            }
//        return returnValue
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let myCell = favTabelView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath)
//        switch (segmentedControl.selectedSegmentIndex) {
//        case 0:
//            myCell.textLabel?.text = eventString[indexPath.row]
//            break
//        case 1:
//            myCell.textLabel?.text = churchString[indexPath.row]
//            break
//        default:
//            break
//        }
//        
//        return myCell
//    }
//    
//}
