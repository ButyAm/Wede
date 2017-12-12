//
//  LoginViewController.swift
//  WedeChurchIOS
//
//  Created by Muluken on 3/22/17.
//  Copyright © 2017 GCME. All rights reserved.
//

import UIKit
import SVProgressHUD
import MBProgressHUD
import SystemConfiguration

class LoginViewController: UIViewController, UITextFieldDelegate {
    
//    public class func standardController() -> LoginViewController {
//        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
//    }
//    
    var dictResponse: NSDictionary = [:]
    var dictProfile : NSDictionary = [:]
    
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPass: UITextField!

    
    @IBOutlet weak var btnLogin: UIButton!
    var usernameString: NSString? = nil

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
//        displayWalkthroughs()
        // Hide the navigation bar & tab bar on the this view controller
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
//        self.tabBarController?.tabBar.isHidden = true
    }
    
//    func displayWalkthroughs()
//    {
//        // check if walkthroughs have been shown
//        let userDefaults = UserDefaults.standard
//        let displayedWalkthrough = userDefaults.bool(forKey: "DisplayedWalkthrough")
//
//        // if we haven't shown the walkthroughs, let's show them
//        if !displayedWalkthrough {
//            // instantiate neew PageVC via storyboard
//            if let pageViewController = storyboard?.instantiateViewController(withIdentifier: "welcomeScreen") as? WelcomeViewController {
//                self.present(pageViewController, animated: true, completion: nil)
//            }
//        }
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtEmail.delegate = self
        txtPass.delegate = self
        
        // Do any additional setup after loading the view.
    }
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(true)
//        navigationController?.setNavigationBarHidden(false, animated: false)
//    }
    
    @IBAction func skipLogin(_ sender: Any) {
        
        // we're good with the walk through.
        // also, don't forget to update userdefaults
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: "DisplayedWalkthrough")
        
        // but wait, how did you know that we displayed the PageVC via a modal segue? We didn't! Let's display the PageVC before doing anything else
        if let homeViewCOntrol = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController {
            self.present(homeViewCOntrol, animated: true, completion: nil)
        }
    }
    
 
  
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        if textField == self.txtEmail {
            self.txtPass.becomeFirstResponder()
        }
        if textField == self.txtPass {
            
            self.ClickedLogin(self)
        }
        return true
    }

 
    
    @IBAction func ClickedLogin(_ sender: Any) {
    
        view.endEditing(true)
        if ((txtEmail.text?.length)! > 0 && (txtPass.text?.length)! > 0) {
            
           
                if isInternetAvailable() {
                    self.validateLoginDetails()
                }else{
                    self.validateLoginDetailsFromDB()
                }
                
            
        }else{
            self.displayMyAlertMessage(userMessage: "both the fields are required");

           // self.presentAlertWithTitle(title: "Sorry", message: "Both the fields are required")
        }
    }
    func validateLoginDetailsFromDB(){
        if (txtEmail.text?.length)! > 0  {
            if txtEmail.text! as NSString? == UserDefaults.standard.value(forKey: "userEmail") as! NSString? && txtPass.text! as NSString? == UserDefaults.standard.value(forKey: "userPassword") as! NSString? {
                self.performSegue(withIdentifier: "showHomeView", sender: self)
            }else{
                displayMyAlertMessage(userMessage: "You are not connected to the internet. Please connect to the internet to perform this action.");
                  }
        }
    }
    func validateLoginDetails(){
      //  self.showMBProgressHUD()
       // SVProgressHUD.show()
        if (txtEmail.text?.length)! > 0  {
            usernameString = txtEmail.text! as NSString
        }
        
        
        let url = NSURL(string: "http://wede.myims.org/api")!
        let request:NSMutableURLRequest = NSMutableURLRequest(url:url as URL)
        let bodyData = String(format: "user_name=%@&user_pass=%@&service=%@&param=[]",txtEmail.text!,txtPass.text!,"log_in","")
        print("body=",bodyData)
        request.httpMethod = "POST"
        request.httpBody = bodyData.data(using: String.Encoding.utf8);
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request as URLRequest,completionHandler: {(data,response,error) in
          //  self.hideMBProgressHUD()
//            SVProgressHUD.dismiss()
            
            if let HTTPResponse = response as? HTTPURLResponse {
                let statusCode = HTTPResponse.statusCode
                if statusCode == 200 {
                    do {
                        if data != nil {
                            let jsonResult = try JSONSerialization.jsonObject(with: data!, options:
                                JSONSerialization.ReadingOptions.mutableContainers)
                           // print(jsonResult)
                            if let list = jsonResult as? NSDictionary {
                                if let Request_Error = list["Request_Error"] as? NSDictionary {
                                    self.displayMyAlertMessage(userMessage: (Request_Error.allValues.first as? String ?? "")!);
                                }else if list["response"] as? NSDictionary != nil {
                                    self.dictResponse = (list["response"] as? NSDictionary)!
                                  //  print(self.dictResponse)
                                    
                                        UserDefaults.standard.set(self.txtEmail.text, forKey: "userName")
                                        UserDefaults.standard.set(self.txtPass.text, forKey: "userPassword")
                                        UserDefaults.standard.set(self.dictProfile["email"] as? String, forKey: "email")
                                        UserDefaults.standard.set(self.dictProfile["phone"] as? String, forKey: "phone")
                                        UserDefaults.standard.set(self.dictProfile["full_name"] as? String, forKey: "full_name")
                                        UserDefaults.standard.set(true,forKey:"isUserLoggedIn");

                                        UserDefaults.standard.synchronize()
                                        self.dismiss(animated: true, completion: nil)
                                        //self.performSegue(withIdentifier: "showHomeView", sender: self)
                                    
                                }else{}
                            }
                        }else{
                            self.displayMyAlertMessage(userMessage: "Something went wrong. Please try again later.");

                           // self.presentAlertWithTitle(title: "Sorry", message: "Something went wrong. Please try again later.")
                        }
                    } catch let error as NSError {
                        print("error=",error)
                        self.displayMyAlertMessage(userMessage: error.localizedDescription);
                      //  self.presentAlertWithTitle(title: "Sorry", message: error.localizedDescription)
                    } catch {
                        self.displayMyAlertMessage(userMessage: error.localizedDescription);
                      //  self.presentAlertWithTitle(title: "Sorry", message: error.localizedDescription)
                    }
                } else {
                    self.displayMyAlertMessage(userMessage: "Something went wrong. Please try again later.");
                  //  self.presentAlertWithTitle(title: "Sorry", message: "Something went wrong. Please try again later.")
                }
            }
            
        }
        )
        dataTask.resume()
//        NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main)
//        {
//            (response, data, error) in
//            
//        }
    }
    
    func showMBProgressHUD() {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = MBProgressHUDMode.indeterminate
        hud.label.text = "Authenticating..."
    }
    
    func hideMBProgressHUD() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak public var backgroundTapGestureRecognizer: UITapGestureRecognizer!
    
    //public var delegate: SignupViewControllerDelegate?
    
    
    
    
   
    
    
    
    //MARK: Validation
    
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
private extension String {
    var length: Int {
        return utf16.count
    }
    
    
    
}
