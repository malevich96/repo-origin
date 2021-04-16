//
//  FriendTableViewHeader.swift
//  VK1_App
//
//  Created by Анатолий Левин on 23.03.2021.
//

import UIKit

class FriendTableViewHeader: UITableViewHeaderFooterView {
    
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        let view = UIView()
        view.backgroundColor = .systemBackground
        backgroundView = view
    }
    
    func configure(text: String){
        titleLabel.text = text 
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
    
}
