//
//  FavChurchVC.swift
//  WedeChurchIOS
//
//  Created by Muluken on 6/22/17.
//  Copyright © 2017 GCME. All rights reserved.
//

import UIKit

class FavChurchVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    @IBOutlet weak var favChurchImage: UIImageView!

    @IBOutlet weak var favChurchName: UILabel!
   
    @IBOutlet weak var collectionView: UICollectionView!
    var cellIdentifier = "favChurchCell"
   // var numberOfItemsPerRow : Int = 2
    var myChurchEventName:[String]?
    var myChurchEventImage:[String]?
    
    var SentData1:String!
    var SentData2:String!
    var SentData3:String!
    
    // sending images to detail event view
    var sendFavChurchEventTitle: AnyObject? {
        
        get {
            return UserDefaults.standard.object(forKey: "sendFavChurchEventName") as AnyObject?
        }
        set {
            UserDefaults.standard.set(newValue!, forKey: "sendFavChurchEventName")
            UserDefaults.standard.synchronize()
        }
    }
    var sendFavChurchEventImages: AnyObject? {
        
        get {
            return UserDefaults.standard.object(forKey: "sendFavChurchEventImage") as AnyObject?
        }
        set {
            UserDefaults.standard.set(newValue!, forKey: "sendFavChurchEventImage")
            UserDefaults.standard.synchronize()
        }
    }
 
 
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        favChurchName.text = SentData1
        
        //        myChurchName.text = labeldetail as? String
                favChurchImage.image = UIImage(named: SentData2)
        //
        
        // navigation controller items control
        // self.navigationController?.setNavigationBarHidden(true, animated: true)
        collectionView.dataSource = self
        collectionView.delegate = self
        self.myChurchEventName = ["Event1","Event2","Event3","Event4"]
        self.myChurchEventImage = ["church","mekane","yougo","church"]
    }
    
    
    // MARK: <UICollectionViewDataSource>
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! FavChurchesCollectionViewCell
        cell.indexPath = indexPath
        //  cell.topButton.backgroundColor = UIColor .blue
       // cell.layer.cornerRadius = 20.0;
        // cell.layer.borderColor = UIColor.green.cgColor
        // cell.topLabel.textColor = UIColor.blue
        cell.myFavChurchEventImage.image = UIImage(named: (self.myChurchEventImage?[indexPath.row])!)
        
        cell.myFavChurchEventName!.text = self.myChurchEventName![indexPath.row];
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.myChurchEventName!.count
    }
    
    
    
    // MARK: <UICollectionViewDelegateFlowLayout>
   
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        sendFavChurchEventTitle = myChurchEventName? [indexPath.row] as AnyObject?
        sendFavChurchEventImages = myChurchEventImage? [indexPath.row] as AnyObject?
        
        
    }
    
}


