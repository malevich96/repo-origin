//
//  AllGroupsTableViewController.swift
//  VK1_App
//
//  Created by Анатолий Левин on 09.04.2021.
//

import UIKit

struct Community: Equatable {
    var name: String
    var image: UIImage
}

class AllGroupsTableViewController: UITableViewController {

    var communitys = [
        Community(name: "Apple", image: #imageLiteral(resourceName: "pic")),
        Community(name: "Marvel", image: #imageLiteral(resourceName: "image2"))
    ]
    
    
    var selectedCommunity: Community?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return communitys.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! GroupTableViewCell
        let community = communitys[indexPath.row]
        cell.titleLabel.text = community.name
        cell.CommunityPhotosImageView.image = community.image
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedCommunity = communitys[indexPath.row]
        performSegue(withIdentifier: "addGroup", sender: self)
    }
}
