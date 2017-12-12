//
//  EventMainViewController.swift
//  WedeChurchIOS
//
//  Created by Muluken on 5/8/17.
//  Copyright © 2017 GCME. All rights reserved.
//

import UIKit

class EventMainViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout , UISearchBarDelegate {
    @IBOutlet weak var menuBar: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionSearchBar: UISearchBar!
    var cellIdentifier = "Cell"
    var numberOfItemsPerRow : Int = 2
    var eventNames:[String]?
    var EventImages:[String]?
    var dataSourceForSearchResult:[String]?
    var searchBarActive:Bool = false
    var searchBarBoundsY:CGFloat?
    var refreshControl:UIRefreshControl?
    
    // sending images to detail event view
    var eventName: AnyObject? {
        
        get {
            return UserDefaults.standard.object(forKey: "eventName") as AnyObject?
        }
        set {
            UserDefaults.standard.set(newValue!, forKey: "eventName")
            UserDefaults.standard.synchronize()
        }
    }
    var eventImage: AnyObject? {
        
        get {
            return UserDefaults.standard.object(forKey: "eventImage") as AnyObject?
        }
        set {
            UserDefaults.standard.set(newValue!, forKey: "eventImage")
            UserDefaults.standard.synchronize()
        }
    }
    // collection items size
    var cellWidth:CGFloat{
        return collectionView.frame.size.width/2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // navigation drawer in menu bars
        if revealViewController() != nil {
            
            menuBar.target = revealViewController()
            menuBar.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
        
       // navigation controller items control
       // self.navigationController?.setNavigationBarHidden(true, animated: true)
        collectionSearchBar.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        self.eventNames = ["Event1","Event2","Event3","Event4","Event5","Event6","Event7","Event8","Event9", "Event10"]
        self.EventImages = ["app_logo","app_logo","app_logo","app_logo","app_logo", "app_logo","app_logo","app_logo", "app_logo", "app_logo", "app_logo" ,"app_logo"]
        self.dataSourceForSearchResult = [String]()
    }
    
    // MARK: Search
    func filterContentForSearchText(searchText:String){
        self.dataSourceForSearchResult = self.eventNames?.filter({ (text:String) -> Bool in
            return text.contains(searchText)
        })
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 0 {
            self.searchBarActive    = true
            self.filterContentForSearchText(searchText: searchText)
            self.collectionView?.reloadData()
        }else{
            self.searchBarActive = false
            self.collectionView?.reloadData()
        }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self .cancelSearching()
        self.collectionView?.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBarActive = true
        self.view.endEditing(true)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.collectionSearchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchBarActive = false
        self.collectionSearchBar.setShowsCancelButton(false, animated: false)
    }
    func cancelSearching(){
        self.searchBarActive = false
        self.collectionSearchBar.resignFirstResponder()
        self.collectionSearchBar.text = ""
    }
    
    
    // MARK: <UICollectionViewDataSource>
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CollectionViewCell
        cell.indexPath = indexPath
        //  cell.topButton.backgroundColor = UIColor .blue
        cell.layer.borderWidth = 1.0;
        // cell.layer.borderColor = UIColor.green.cgColor
       // cell.topLabel.textColor = UIColor.blue
        cell.imagecol.image = UIImage(named: (self.EventImages?[indexPath.row])!)
        if (self.searchBarActive) {
            cell.topLabel!.text = self.dataSourceForSearchResult![indexPath.row];
        }else{
            cell.topLabel!.text = self.eventNames![indexPath.row];
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.searchBarActive {
            return self.dataSourceForSearchResult!.count;
        }
        return self.eventNames!.count
    }
    
   
    
    // MARK: <UICollectionViewDelegateFlowLayout>
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(numberOfItemsPerRow - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(numberOfItemsPerRow))
        return CGSize(width: size, height: size)
    }
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        eventName = eventNames? [indexPath.row] as AnyObject?
        eventImage = EventImages? [indexPath.row] as AnyObject?

        
    }
    
}


