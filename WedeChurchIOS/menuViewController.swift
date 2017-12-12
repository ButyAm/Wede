//
//  menuViewController.swift
//  WedeChurchIOS
//
//  Created by Muluken on 3/30/17.
//  Copyright © 2017 GCME. All rights reserved.
//

import UIKit

class menuViewController: UIViewController {
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    }
    
  
    @IBAction func onLogoutBtnClicked(_ sender: Any) {
        
        UserDefaults.standard.set(false,forKey:"isUserLoggedIn");
        UserDefaults.standard.synchronize();
        
        self.performSegue(withIdentifier: "loginAgain", sender: self);
       // self.dismiss(animated: true, completion: nil)
    }
 
}
