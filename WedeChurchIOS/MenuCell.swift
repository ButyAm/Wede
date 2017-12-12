//
//  MenuCell.swift
//  WedeChurchIOS
//
//  Created by Muluken on 3/30/17.
//  Copyright © 2017 GCME. All rights reserved.
//

import UIKit
import SystemConfiguration

class MenuCell: UIViewController {
    
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        displayWalkthroughs()
    }
    
    func displayWalkthroughs()
    {
        // check if walkthroughs have been shown
        let userDefaults = UserDefaults.standard
        let displayedWalkthrough = userDefaults.bool(forKey: "DisplayedWalkthrough")
        
        // if we haven't shown the walkthroughs, let's show them
        if !displayedWalkthrough {
            // instantiate neew PageVC via storyboard
            if let pageViewController = storyboard?.instantiateViewController(withIdentifier: "PageViewController") as? PageViewController {
                self.present(pageViewController, animated: true, completion: nil)
            }
        }
    }
    
    
    
    @IBAction func loginButtonTapped(_ sender: AnyObject) {
        
        if isInternetAvailable() {
            
            print("there is internet available")
            
            let userEmail = userEmailTextField.text;
            let userPassword = userPasswordTextField.text;
            
            if (userEmail?.isEmpty)! || (userPassword?.isEmpty)!
            {
                
                // Display alert message
                
                displayMyAlertMessage(userMessage: "All fields are required");
                
                return;
            }
            
            
            
            
        } else
        {
            print("connect to internet")
        }
        
    }
    
    
    func logininin() {
        
        
        let userEmail = userEmailTextField.text;
        let userPassword = userPasswordTextField.text;
        
        
        
        
        
        
        let parameters = ["user_name": userEmail, "user_pass": userPassword, "service": "log_in" , "param": ""]
        
        
        
        //  let parameters = ["post_id": "EVSQHX", "post_secret": "beurry", "service": "auth" , "param": ""]
        
        guard let url = URL(string: "http://wede.myims.org/api") else { return }
        
        
        if userEmailTextField.text == userEmail && userPasswordTextField.text == userPassword {
            
            
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            //  request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            
            
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
            request.httpBody = httpBody
            
            
            
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 200 {           // check for http errors
                    // print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    UserDefaults.standard.set(userEmail, forKey:"userEmail")
                    UserDefaults.standard.set(userPassword, forKey:"userPassword")
                    UserDefaults.standard.synchronize();
                    
                    let userEmailStored = UserDefaults.standard.string(forKey: "userEmail");
                    
                    let userPasswordStored = UserDefaults.standard.string(forKey: "userPassword");
                    
                    if(userEmailStored == userEmail)
                    {
                        if(userPasswordStored == userPassword)
                        {
                            // Login is successfull
                            UserDefaults.standard.set(true,forKey:"isUserLoggedIn");
                            UserDefaults.standard.synchronize();
                            
                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                    
                    
                }
                    
                else if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                    let myLoginAlert = UIAlertController(title:"Login", message:"Login Failed", preferredStyle: UIAlertControllerStyle.alert);
                    
                    let loginResponse = UIAlertAction(title:"Ok", style:UIAlertActionStyle.default){ action in
                        self.dismiss(animated: true, completion:nil);
                    }
                    
                    myLoginAlert.addAction(loginResponse);
                }
                if let error = error {
                    print(error)
                    print("ther is error")
                }
                
                if let data = data {
                    do {
                        
                        
                        if let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary {//because JSON data started with dictionary. Not an array
                            print(json)
                            
                        }
                        else {
                            print("json error")
                        }
                    }
                    catch {
                        print("error caught")
                        
                    }
                    
                }else {
                    print("error found")
                }
                }.resume()
            
            
            
            //            } else {
            //                print("portName or PortSecret is wrong")
            //                self.mySwitch.isOn = false
            //            }
            
            
            
        }
            
        else {
            print("your credentials are incorrect")
        }
        
    }
    
    
    func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    func displayMyAlertMessage(userMessage:String)
    {
        
        let myAlert = UIAlertController(title:"Alert", message:userMessage, preferredStyle: UIAlertControllerStyle.alert);
        
        let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.default, handler:nil);
        
        myAlert.addAction(okAction);
        
        self.present(myAlert, animated:true, completion:nil);
        
    }
    
}
