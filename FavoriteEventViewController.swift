//
//  FavoriteEventViewController.swift
//  WedeChurchIOS
//
//  Created by Muluken on 6/13/17.
//  Copyright © 2017 GCME. All rights reserved.
//

import UIKit

class FavoriteEventViewController: UIViewController, UITableViewDataSource ,UITableViewDelegate {
    
    @IBOutlet weak var favEventTableView: UITableView!
    
    @IBOutlet weak var menuBar: UIBarButtonItem!
    
    
   // @IBOutlet weak var menuBar: UIBarButtonItem!
   //send files to detailview
    var sendFavNameEvents: AnyObject? {
        
        get {
            return UserDefaults.standard.object(forKey: "favEventName") as AnyObject?
        }
        set {
            UserDefaults.standard.set(newValue!, forKey: "favEventName")
            UserDefaults.standard.synchronize()
        }
    }
    var sendFavImageEvent: AnyObject? {
        
        get {
            return UserDefaults.standard.object(forKey: "favEventImage") as AnyObject?
        }
        set {
            UserDefaults.standard.set(newValue!, forKey: "favEventImage")
            UserDefaults.standard.synchronize()
        }
    }

    
    
    var eventString = ["one", "two", "three", "four"]
    var eventImages = ["yougo", "yougo", "yougo","yougo"]
    override func viewDidLoad() {
        super.viewDidLoad()
        if revealViewController() != nil {
            
            menuBar.target = revealViewController()
            menuBar.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return eventImages.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = favEventTableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! FavEventTableViewCell
        myCell.eventImage.image = UIImage(named: eventImages[indexPath.row])!
        myCell.eventTitle.text = eventString[indexPath.row]
        
        return myCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            eventString.remove(at: indexPath.row)
            eventImages.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        sendFavNameEvents = eventString[indexPath.row] as AnyObject?
        sendFavImageEvent = eventImages[indexPath.row] as AnyObject?
        
        
        
    }
}
