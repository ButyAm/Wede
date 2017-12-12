//
//  ProfileViewController.swift
//  WedeChurchIOS
//
//  Created by Muluken on 6/13/17.
//  Copyright © 2017 GCME. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var menuButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        // navigation drawer in menu bars
        if revealViewController() != nil {
            
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        
        UserDefaults.standard.set(false,forKey:"isUserLoggedIn");
        UserDefaults.standard.synchronize();
    
        if let pageViewController = storyboard?.instantiateViewController(withIdentifier: "welcomeScreen") as? WelcomeViewController {
            self.present(pageViewController, animated: true, completion: nil)
        }
    
    
    }

   

}
