//
//  FavoriteHomeChurchViewController.swift
//  WedeChurchIOS
//
//  Created by Muluken on 6/13/17.
//  Copyright © 2017 GCME. All rights reserved.
//

import UIKit

class FavoriteHomeChurchViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    @IBOutlet weak var myChurchImage: UIImageView!
    @IBOutlet weak var myChurchName: UILabel!
    
    @IBOutlet weak var menuBar: UIBarButtonItem!

    @IBOutlet weak var collectionView: UICollectionView!
    var cellIdentifier = "myChurchCell"
    var numberOfItemsPerRow : Int = 2
    var myChurchEventName:[String]?
    var myChurchEventImage:[String]?
    
    var refreshControl:UIRefreshControl?
    
    // sending images to detail event view
    var sendChurchEventTitle: AnyObject? {
        
        get {
            return UserDefaults.standard.object(forKey: "sendMyChurchEventName") as AnyObject?
        }
        set {
            UserDefaults.standard.set(newValue!, forKey: "sendMyChurchEventName")
            UserDefaults.standard.synchronize()
        }
    }
    var sendChurchEventImages: AnyObject? {
        
        get {
            return UserDefaults.standard.object(forKey: "sendMyChurchEventImage") as AnyObject?
        }
        set {
            UserDefaults.standard.set(newValue!, forKey: "sendMyChurchEventImage")
            UserDefaults.standard.synchronize()
        }
    }
    // collection items size
    var cellWidth:CGFloat{
        return collectionView.frame.size.width/2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if revealViewController() != nil {
            
            menuBar.target = revealViewController()
            menuBar.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
        
//        myChurchName.text = labeldetail as? String
//        myChurchImage.image = UIImage(named: imageDetail as! String)
//        
        
        // navigation controller items control
        // self.navigationController?.setNavigationBarHidden(true, animated: true)
        collectionView.dataSource = self
        collectionView.delegate = self
        self.myChurchEventName = ["Event1","Event2","Event3","Event4","Event5","Event6","Event7","Event8","Event9", "Event10"]
        self.myChurchEventImage = ["church","mekane","yougo","church","mekane","yougo","church","mekane","yougo", "church","mekane","yougo"]
    }
    
    
    // MARK: <UICollectionViewDataSource>
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyChurchCollectionViewCell
        cell.indexPath = indexPath
        //  cell.topButton.backgroundColor = UIColor .blue
     //   cell.layer.cornerRadius = 20.0;
        // cell.layer.borderColor = UIColor.green.cgColor
        // cell.topLabel.textColor = UIColor.blue
        cell.myChurchEventImage.image = UIImage(named: (self.myChurchEventImage?[indexPath.row])!)
        
        cell.myChurchEventName!.text = self.myChurchEventName![indexPath.row];
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.myChurchEventName!.count
    }
    
    
    
    // MARK: <UICollectionViewDelegateFlowLayout>
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
//        let totalSpace = flowLayout.sectionInset.left
//            + flowLayout.sectionInset.right
//            + (flowLayout.minimumInteritemSpacing * CGFloat(numberOfItemsPerRow - 1))
//        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(numberOfItemsPerRow))
//        return CGSize(width: size, height: size)
//    }
//    
//    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
//        return CGRect(x: x, y: y, width: width, height: height)
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        sendChurchEventTitle = myChurchEventName? [indexPath.row] as AnyObject?
        sendChurchEventImages = myChurchEventImage? [indexPath.row] as AnyObject?
        
        
    }
    
}


