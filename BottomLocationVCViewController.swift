//
//  BottomLocationVCViewController.swift
//  WedeChurchIOS
//
//  Created by Muluken on 4/3/17.
//  Copyright © 2017 GCME. All rights reserved.
//

import UIKit
import MapKit

class BottomLocationVCViewController: UIViewController {
    
    var partialView: CGFloat {
        return UIScreen.main.bounds.height - 150
    }
    var fullView: CGFloat = 150
    
    @IBOutlet weak var contentView: UIView!
    enum TabIndex : Int {
        case firstChildTab = 0
        case secondChildTab = 1
    }
    
    @IBOutlet weak var segmentedControl: TabySegmentedControl!
    
    var currentViewController: UIViewController?
    lazy var firstChildTabVC: UIViewController? = {
        let firstChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "ChurchesControllerID")
        return firstChildTabVC
    }()
    lazy var secondChildTabVC : UIViewController? = {
        let secondChildTabVC = self.storyboard?.instantiateViewController(withIdentifier: "EventsControllerID")
        
        return secondChildTabVC
    }()
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGestureForBottomAnimation()
        let titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttributes, for: .selected)
        
        
        
        segmentedControl.initUI()
        segmentedControl.backgroundColor = UIColor(red:24.0/255.0, green:124.0/255.0, blue:123.0/255.0, alpha:1.0)
        segmentedControl.tintColor = UIColor(red:7.0/255.0, green:180.0/255.0, blue:177.0/255.0, alpha:1.0)
        segmentedControl.selectedSegmentIndex = TabIndex.firstChildTab.rawValue
        displayCurrentTab(TabIndex.firstChildTab.rawValue)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animateAfterViewAppear()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let currentViewController = currentViewController {
            currentViewController.viewWillDisappear(animated)
        }
    }
    
    @IBAction func switchTabs(_ sender: UISegmentedControl) {
        self.currentViewController!.view.removeFromSuperview()
        self.currentViewController!.removeFromParentViewController()
        
        displayCurrentTab(sender.selectedSegmentIndex)
    }

    func displayCurrentTab(_ tabIndex: Int){
        if let vc = viewControllerForSelectedSegmentIndex(tabIndex) {
            
            self.addChildViewController(vc)
            vc.didMove(toParentViewController: self)
            
            vc.view.frame = self.contentView.bounds
            self.contentView.addSubview(vc.view)
            self.currentViewController = vc
        }
    }
    
    func viewControllerForSelectedSegmentIndex(_ index: Int) -> UIViewController? {
        var vc: UIViewController?
        switch index {
        case TabIndex.firstChildTab.rawValue :
            vc = firstChildTabVC
        case TabIndex.secondChildTab.rawValue :
            vc = secondChildTabVC
        default:
            return nil
        }
        
        return vc
    }
    
}

extension BottomLocationVCViewController:UIGestureRecognizerDelegate{
    func addGestureForBottomAnimation(){
        let swipedOnImage = UIPanGestureRecognizer(target: self, action: #selector(self.panGesture(recognizer:)))
        view.addGestureRecognizer(swipedOnImage)
        view.isUserInteractionEnabled = true
        swipedOnImage.delegate = self
    }
    
    //MARK:- Animate afterViewWill Appear
    func animateAfterViewAppear(){
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.8, options: .curveLinear, animations: {
            self.view.frame = CGRect(x: 0, y: self.fullView, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    
    //MARK:- animate by dragging view
    @objc func panGesture(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation( in: self.view)
        let velocity = recognizer.velocity(in: self.view)
        let y = self.view.frame.minY
        //translate y postion when drag within fullview to partial view
        if (y + translation.y >= fullView) && (y + translation.y <= partialView) {
            
            self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
            recognizer.setTranslation(CGPoint(x:0,y:0), in: self.view)
        }
        if recognizer.state == .ended {
            var duration =  velocity.y < 0 ? Double((y - fullView) / -velocity.y) : Double((partialView - y) / velocity.y )
            
            duration = duration > 1.5 ? 1 : duration
            UIView.animate(withDuration: duration, delay: 0.0, options: [.allowUserInteraction], animations: {
                if  velocity.y >= 0 {
                    self.view.frame = CGRect(x: 0, y: self.partialView, width: self.view.frame.width, height: self.view.frame.height)
                } else {
                    
                    self.view.frame = CGRect(x: 0, y: self.fullView, width: self.view.frame.width, height: self.view.frame.height)
                }
                
            }, completion: nil)
        }
    }
    
    
}

