//
//  FavDetailEventVC.swift
//  WedeChurchIOS
//
//  Created by Muluken on 6/22/17.
//  Copyright © 2017 GCME. All rights reserved.
//

import UIKit

class FavDetailEventVC: UIViewController {
    @IBOutlet weak var favDetailImage: UIImageView!
    
    @IBOutlet weak var favDetailEventView: UITextView!
    @IBOutlet weak var favDetaileventLabel: UILabel!
    
    var getFavEventName: AnyObject? {
        
        get {
            return UserDefaults.standard.object(forKey: "favEventName") as AnyObject?
        }
        
    }
    //get imagesfrom main eventviewcntroller
    var getFavEventImage: AnyObject? {
        
        get {
            return UserDefaults.standard.object(forKey: "favEventImage") as AnyObject?
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favDetaileventLabel.text = getFavEventName as? String
        favDetailImage.image = UIImage(named: getFavEventImage as! String)
        // detailImage.layer.cornerRadius = 20.0
        
        
        
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
