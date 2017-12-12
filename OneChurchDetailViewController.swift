//
//  OneChurchDetailViewController.swift
//  WedeChurchIOS
//
//  Created by Muluken on 6/8/17.
//  Copyright © 2017 GCME. All rights reserved.
//

import UIKit

class OneChurchDetailViewController: UIViewController {

    @IBOutlet weak var locationEvent: UILabel!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var detailEventImage: UIImageView!
    @IBOutlet weak var eventDetailView: UILabel!
    
    
    var churchEventListName: AnyObject? {
        
        get {
            return UserDefaults.standard.object(forKey: "churchEventName") as AnyObject?
        }
        
    }
    //get imagesfrom main eventviewcntroller
    var churchEventListImage: AnyObject? {
        
        get {
            return UserDefaults.standard.object(forKey: "churchEventImage") as AnyObject?
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        eventTitle.text = churchEventListName as? String
        detailEventImage.image = UIImage(named: churchEventListImage as! String)

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
