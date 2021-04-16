//
//  GroupTableViewCell.swift
//  VK1_App
//
//  Created by Анатолий Левин on 08.03.2021.
//

import UIKit

class GroupTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var CommunityPhotosImageView: UIImageView!
  
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
    }
}

