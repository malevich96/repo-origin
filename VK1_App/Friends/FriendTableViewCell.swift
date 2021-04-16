//
//  FriendTableViewCell.swift
//  VK1_App
//
//  Created by Анатолий Левин on 23.03.2021.
//

import UIKit

class FriendTableViewCell: UITableViewCell {

    @IBOutlet weak var friendNameLabel: UILabel!
    @IBOutlet weak var FriendProfilePhotoImageView: UIImageView!
    @IBInspectable var showDisclosureArrow: Bool = false {
        didSet{
            if showDisclosureArrow {
                accessoryType = .disclosureIndicator
            } else {
                accessoryType = .none
        }
    }
}
    override func prepareForReuse() {
        super.prepareForReuse()
        friendNameLabel.text = ""
        showDisclosureArrow = false
    }
}
