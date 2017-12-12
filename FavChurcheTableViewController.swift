//
//  FavChurcheTableViewController.swift
//  WedeChurchIOS
//
//  Created by Muluken on 6/22/17.
//  Copyright © 2017 GCME. All rights reserved.
//

import UIKit

class FavChurcheTableViewController: UITableViewController {

    
    @IBOutlet weak var menuBar: UIBarButtonItem!
    
    
    //send files to favDetailChurchVC
    var sendFavChurchName: AnyObject? {
        
        get {
            return UserDefaults.standard.object(forKey: "myfavChurchName") as AnyObject?
        }
        set {
            UserDefaults.standard.set(newValue!, forKey: "myfavChurchName")
            UserDefaults.standard.synchronize()
        }
    }
    var sendFavChurchImage: AnyObject? {
        
        get {
            return UserDefaults.standard.object(forKey: "myfavChurchImage") as AnyObject?
        }
        set {
            UserDefaults.standard.set(newValue!, forKey: "myfavChurchImage")
            UserDefaults.standard.synchronize()
        }
    }
    
    var eventString = ["one", "two", "three", "four"]
    var favChurchNames = ["Mekane Yesus" , "Mulu Wongel" , "Hiwot BIrhan", "Mekane Yesus"]
    var favChurchImages = ["yougo", "yougo", "yougo","yougo"]

    
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return favChurchNames.count
    }
    
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "favChurcheCell", for: indexPath) as! FavChurchesTableViewCell
        myCell.churchImage.image = UIImage(named: (favChurchImages[indexPath.row]))!
        myCell.churchName.text = favChurchNames[indexPath.row]
        
        return myCell
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            favChurchNames.remove(at: indexPath.row)
            favChurchImages.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "favChurchDetail") {
            
            let VC = segue.destination as! FavChurchVC
            if let indexpath = self.tableView.indexPathForSelectedRow {
                
                let Title = favChurchNames[indexpath.row] as String
                VC.SentData1 = Title
               // print(devotionalArray)
                
                
                
                let Imageview = favChurchImages[indexpath.row] as String
                VC.SentData2 = Imageview
                
                //                let Imageview2 = imageGoalBot[indexpath.row] as String
                //                VC.SentData5 = Imageview2
                
            }
            
            
        }
    }
    
}
