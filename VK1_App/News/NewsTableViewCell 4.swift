//
//  NewsTableViewCell.swift
//  VK1_App
//
//  Created by Анатолий Левин on 01.04.2021.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var  avatarImageView: UIImageView!
    @IBOutlet weak var  authorLable: UILabel!
    @IBOutlet weak var  timeLable: UILabel!
    @IBOutlet weak var  postLabel: UILabel!
    @IBOutlet weak var  postImageView: UIImageView!
    
   // @IBOutlet weak var  likeBotton: LikeButton!
   // @IBOutlet weak var  commentButton: LikeButton!
   // @IBOutlet weak var  repostButton: LikeButton!
   // @IBOutlet weak var  viewsButton: LikeButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
