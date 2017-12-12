//
//  FavChurchDetailEventVC.swift
//  WedeChurchIOS
//
//  Created by Muluken on 6/25/17.
//  Copyright © 2017 GCME. All rights reserved.
//

import UIKit

class FavChurchDetailEventVC: UIViewController {

    @IBOutlet weak var locationEvent: UILabel!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var detailEventImage: UIImageView!
    
    @IBOutlet weak var eventDetailView: UITextView!
    
    var getFavChurchEventName: AnyObject? {
        
        get {
            return UserDefaults.standard.object(forKey: "sendFavChurchEventName") as AnyObject?
        }
        
    }
    //get imagesfrom main eventviewcntroller
    var getFavChurchEventImage: AnyObject? {
        
        get {
            return UserDefaults.standard.object(forKey: "sendFavChurchEventImage") as AnyObject?
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        eventTitle.text = getFavChurchEventName as? String
        detailEventImage.image = UIImage(named: getFavChurchEventImage as! String)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
