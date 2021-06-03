//
//  FotoCollectionViewCell.swift
//  VK1_App
//
//  Created by Анатолий Левин on 11.03.2021.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var photos: UIImageView!
    @IBOutlet weak var likesCount: UILabel!
    @IBOutlet weak var heartButton: UIButton!
    
    var heartButtonTap: (() -> ())?
    
    @IBAction func clickLike(_ sender: UIButton) {
        heartButtonTap?()
    }
}

