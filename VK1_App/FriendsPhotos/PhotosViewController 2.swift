//
//  FotoViewController.swift
//  VK1_App
//
//  Created by Анатолий Левин on 11.03.2021.
//

import UIKit
import Alamofire
import AlamofireImage

class PhotosViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    var user: VKUser?
    var photos = [UIImage]()
    var selectedIndex = 0
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
    
    }
    
    
    func numberOfSections(in colllectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotosCollectionViewCell
        cell.photos.image = photos[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        self.performSegue(withIdentifier: "toDetail" , sender: self )
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail",
        let destination = segue.destination as? BrowsingPhotosViewController {
            destination.selectedIndex = selectedIndex
            destination.photos = photos
        }
    }
}
