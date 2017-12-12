//
//  HomeChurchesTableVC.swift
//  WedeChurchIOS
//
//  Created by Muluken on 7/12/17.
//  Copyright © 2017 GCME. All rights reserved.
//

import UIKit

class HomeChurchesTableVC: UITableViewController {

    var homeChurchesListNames: [String] = [String]()
    var homeChurchListImages: [String] = [String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 98.0;
        
        self.homeChurchListImages = ["church","mekane","yougo","church","mekane","yougo","church","mekane","yougo", "church","mekane","yougo","church","mekane","yougo","church","mekane","yougo","church","mekane","yougo", "church","mekane","yougo"]
        self.homeChurchesListNames  = [
            "Mekane Yesus" , "Mulu Wongel" , "Hiwot BIrhan" , "Glorious","Beza International" , "Meserete Christos" , "Kale Hiwot" , "You Go" , "Bethel" , "Glorious", "Mekane Yesus" , "Mulu Wongel" , "Hiwot BIrhan" , "Glorious","Beza International" , "Meserete Christos" , "Kale Hiwot" , "You Go" , "Bethel" , "Glorious","Mekane Yesus" , "Mulu Wongel" , "Hiwot BIrhan" , "Glorious"       ]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return homeChurchesListNames.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeChurches", for: indexPath) as! HomeChurchesTableViewCell
        
        cell.homeChurchName.text = homeChurchesListNames[indexPath.row]
        cell.homeChurchImage.image = UIImage(named: homeChurchListImages[indexPath.row])

        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
