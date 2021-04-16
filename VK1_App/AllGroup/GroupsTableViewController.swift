//
//  GroupsTableViewController.swift
//  VK1_App
//
//  Created by Анатолий Левин on 10.03.2021.
//

import UIKit

class GroupsTableViewController: UITableViewController {
    var communitys = [Community]()
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
    
    @IBAction func addCommunity(segue: UIStoryboardSegue){
        if segue.identifier == "addGroup",
           let sourceVC = segue.source as? AllGroupsTableViewController,
           let selectedCommunity = sourceVC.selectedCommunity {
            if !communitys.contains(selectedCommunity){
            }
            communitys.append(selectedCommunity)
            tableView.reloadData()
        }
    }
        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                communitys.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
         }
    }
}


