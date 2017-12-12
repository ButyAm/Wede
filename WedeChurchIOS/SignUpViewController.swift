//
//  SignUpViewController.swift
//  WedeChurchIOS
//
//  Created by Muluken on 3/22/17.
//  Copyright © 2017 GCME. All rights reserved.
//

import UIKit
import SystemConfiguration
import SVProgressHUD
import MBProgressHUD

class SignUpViewController: UIViewController, UITextFieldDelegate {
 
//    public class func standardController() -> SignupViewController {
//        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignupVC") as! SignupViewController
//    }
    
    var dictResponse: NSDictionary = [:]
    var dictProfile : NSDictionary = [:]
    
//    @IBOutlet var getGender: UIPickerView! = UIPickerView()
//
//    let gender = ["Male", "Female"]
//
//    @IBOutlet weak var txtFrstName: UITextField!
//    @IBOutlet weak var txtLstName: UITextField!
    @IBOutlet weak var txtUsrName: UITextField!
//    @IBOutlet weak var txtEmail: UITextField!
//    @IBOutlet weak var txtGender: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak public var txtPhone: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    @IBOutlet weak var txtconfPass: UITextField!
    
    @IBOutlet weak var btnSignup: UIButton!
    @IBOutlet weak var btnAlready: UIButton!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // Hide the navigation bar & tab bar on the this view controller
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
//        self.tabBarController?.tabBar.isHidden = true
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtUsrName.delegate = self
//        txtFrstName.delegate = self
//        txtLstName.delegate = self
//        txtEmail.delegate = self
//        txtGender.delegate = self
        txtCountry.delegate = self
        txtPhone.delegate = self
        txtPass.delegate = self
        txtconfPass.delegate = self
        
        btnAlready.titleLabel?.adjustsFontSizeToFitWidth = true
        
//        getGender.isHidden = true
//        self.txtGender.inputAccessoryView = getGender
        
        //hide keyboard in touching any place
        self.hideKeyboardWhenTappedAround()
    }
    
    
    @IBAction func goToLogin(_ sender: Any) {
        
      //  self.dismiss(animated: true, completion: nil)
        
        if let LoginViewController = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
            self.present(LoginViewController, animated: true, completion: nil)
        }
        
    }
    
//    func numberOfComponentsInPickerView(_ pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    // returns the # of rows in each component..
//    internal func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
//        return gender.count
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return gender[row]
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
//    {
//        txtGender.text = gender[row]
//        getGender.isHidden = true
//
//        self.txtPhone.becomeFirstResponder()
//    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
//        if textField == self.txtGender {
//            txtGender.text = gender[0]
//            getGender.isHidden = false
//
//            self.view.endEditing(true)
//            KeyboardAvoiding.avoidingView = nil
//            return false
//        }else
            if textField == self.txtPass {
            KeyboardAvoiding.avoidingView = self.txtPass
            return true
        }else if textField == self.txtconfPass {
            KeyboardAvoiding.avoidingView = self.txtconfPass
            return true
        }else{
            KeyboardAvoiding.avoidingView = nil
            return true
        }
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        
//        if textField == self.txtPass {
//            UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.repeat, animations: { () -> Void in
//                textField.resignFirstResponder()
//            }, completion: { (finished: Bool) -> Void in
//                self.txtconfPass.becomeFirstResponder()
//            })
//        }else{
//            textField.resignFirstResponder()
//            if textField == self.txtFrstName {
//                self.txtLstName.becomeFirstResponder()
//            }
//            if textField == self.txtLstName {
//                self.txtUsrName.becomeFirstResponder()
//            }
//            if textField == self.txtUsrName {
//                self.txtGender.becomeFirstResponder()
//            }
//            if textField == self.txtGender {
//                self.txtEmail.becomeFirstResponder()
//            }
//            if textField == self.txtEmail {
//                self.txtCountry.becomeFirstResponder()
//            }
//            if textField == self.txtconfPass {
//                
//                self.ClickedSignUp(self)
//            }
//        }
//        return true
//    }
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
//                   replacementString string: String) -> Bool
//    {
//        if(textField == self.txtPhone){
//            let maxLength = 10
//            let currentString: NSString = txtPhone.text! as NSString
//            let newString: NSString =
//                currentString.replacingCharacters(in: range, with: string) as NSString
//            return newString.length <= maxLength
//        }else{
//            
//        }
//        return true
//    }

    
    
    @IBAction func ClickedSignUp(_ sender: Any) {
        view.endEditing(true)
        if ((txtUsrName.text?.length)! > 0 && (txtCountry.text?.length)! > 0 && (txtPhone.text?.length)! > 0 && (txtPass.text?.length)! > 0 && (txtconfPass.text?.length)! > 0) {
            
            
                if (txtPass.text == txtconfPass.text){
                    
                    if isInternetAvailable() {
                        self.registerNewUser()
                    }else{
                        self.displayMyAlertMessage(userMessage: "You are not connected to the internet. Please connect to the internet to perform this action.");
                      //  presentAlertWithTitle(title: "No internet access", message: "You are not connected to the internet. Please connect to the internet to perform this action.")
                    }
                    
                }else{
                    print("Passwords do not match, please retype")
                    self.txtPass.text = nil
                    self.txtconfPass.text = nil
                    self.txtPass.becomeFirstResponder()
                    self.displayMyAlertMessage(userMessage: "Passwords do not match, please retype");
                   // self.presentAlertWithTitle(title: "Sorry", message: "Passwords do not match, please retype")
                }
                
            
        }else{
            print("All fields are required")
            self.displayMyAlertMessage(userMessage: "All fields are required");
           // self.presentAlertWithTitle(title: "Sorry", message: "All fields are required")
        }
        
    }
    func registerNewUser(){
        self.showMBProgressHUD()
        
        
        // prepare json data
        let myArrayOfDict = ["user_name":txtUsrName.text as AnyObject,
                                                    "user_pass":txtPass.text as AnyObject,
                                                    
                                                    "phone":txtPhone.text as AnyObject,
                                                    "country":txtCountry.text as AnyObject]
     
        let json = ["user_name":txtUsrName.text!, "user_pass":txtPass.text!,"service":"register", "param": myArrayOfDict] as [String : Any]
       // print(json)
        // create post request
        let url = NSURL(string: "http://wede.myims.org/api")!
        let jsonData = try! JSONSerialization.data(withJSONObject: json, options: [])
        print("json data:", jsonData)
        var request = URLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            self.hideMBProgressHUD()
            
            if let error = error {
                self.displayMyAlertMessage(userMessage: error.localizedDescription);
                print("error occured")
                return
            }
            
//            if let response = response {
//                print(response)
//            }
            if let HTTPResponse = response as? HTTPURLResponse {
                let statusCode = HTTPResponse.statusCode
                if statusCode == 200 {
                    
                    print("status code 200")
                    do {
                        guard let data = data else { return }
                        
                        guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary else { return }
                        print("json:", json)
                        
                        if let Request_Error = json["Request_Error"] as? NSDictionary {
                            self.displayMyAlertMessage(userMessage: (Request_Error.allValues.first as? String ?? "buty")!)
                        }else if let response = json["response"] as? NSDictionary {
                           // self.dictResponse = Response
                          //  print("Response=",self.dictResponse)
                            print("the response is:",response)
                            
//                            UserDefaults.standard.set(self.txtPass.text, forKey: "password")
//                            UserDefaults.standard.set(self.txtEmail.text, forKey: "email")
//                            UserDefaults.standard.set(self.txtPhone.text, forKey: "phone")
//                            UserDefaults.standard.synchronize()
//                            
//                            self.performSegue(withIdentifier: "showHome", sender: self)
                            
                        }else{}
                        
                    } catch {
                        print("error:", error)
                        self.displayMyAlertMessage(userMessage: error.localizedDescription)
                    }

                }
                else {
                    print(statusCode)
                    self.displayMyAlertMessage(userMessage: "Something went wrong. Please try again later.");
                    //  self.presentAlertWithTitle(title: "Sorry", message: "Something went wrong. Please try again later.")
                }

            }
            
        }
        
        task.resume()
    }
    

    
    @IBOutlet weak public var backgroundTapGestureRecognizer: UITapGestureRecognizer!
    
    

    
//    @IBAction fileprivate func tappedBackground(_ sender: UITapGestureRecognizer) {
//        view.endEditing(true)
//        getGender.isHidden = true
//    }
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

    
//    public var phoneNumberIsValid: Bool {
//        if let phoneNumberLength = txtPhone.text?.length {
//            return phoneNumberLength > 5 && phoneNumberLength < 15
//        }
//        return false
//    }
    
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
//extension String {
//    func isValidEmail() -> Bool {
//        let regex = try? NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
//        return regex?.firstMatch(in: self, options: [], range: NSMakeRange(0, self.characters.count)) != nil
//    }
//}
extension Collection where Iterator.Element == [String:AnyObject] {
    func toJSONString(options: JSONSerialization.WritingOptions = .prettyPrinted) -> String {
        if let arr = self as? [[String:AnyObject]],
            let dat = try? JSONSerialization.data(withJSONObject: arr, options: options),
            let str = String(data: dat, encoding: String.Encoding.utf8) {
            return str
        }
        return "[]"
    }
}

private extension String {
    var length: Int {
        return utf16.count
    }
}


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
