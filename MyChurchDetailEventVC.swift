//
//  MyChurchDetailEventVC.swift
//  WedeChurchIOS
//
//  Created by Muluken on 6/25/17.
//  Copyright © 2017 GCME. All rights reserved.
//

import UIKit

class MyChurchDetailEventVC: UIViewController {
    
    @IBOutlet weak var locationEvent: UILabel!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var detailEventImage: UIImageView!
    
    @IBOutlet weak var eventDetailView: UITextView!
    
    var getMyChurchEventName: AnyObject? {
        
        get {
            return UserDefaults.standard.object(forKey: "sendMyChurchEventName") as AnyObject?
        }
        
    }
    //get imagesfrom main eventviewcntroller
    var getMyChurchEventImage: AnyObject? {
        
        get {
            return UserDefaults.standard.object(forKey: "sendMyChurchEventImage") as AnyObject?
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        eventTitle.text = getMyChurchEventName as? String
        detailEventImage.image = UIImage(named: getMyChurchEventImage as! String)
        
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
