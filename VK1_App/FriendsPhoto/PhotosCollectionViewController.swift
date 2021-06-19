//
//  PhotosCollectionViewController.swift
//  VK1_App
//
//  Created by Анатолий Левин on 02.05.2021.
//

import UIKit
import Alamofire
import AlamofireImage

class FriendPhotosCollectionViewController: UICollectionViewController {
    var userId: Int = 1
    var photos = [VKPhoto]()
    var selectedIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
                
        requestData()
    }
    
    private func requestData() {
        VKService.instance.loadPhotos(userId: userId) { result in
            switch result {
            case .success(let photos):
                self.photos = photos
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendPhotosCollectionViewCell", for: indexPath) as! PhotosCollectionViewCell
        
        let photo = photos[indexPath.row]
        let photoUrl = URL(string: photo.url)!
        cell.photos.af.setImage(withURL: photoUrl)

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            selectedIndex = indexPath.item
            self.performSegue(withIdentifier: "toDetail" , sender: self )
        }
        
          func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "toDetail",
           let destination = segue.destination as? BrowsingPhotosViewController {
              destination.selectedIndex = selectedIndex
              destination.photos = []
            }
       }
}
}
