//
//  FriendsTableViewController.swift
//  VK1_App
//
//  Created by Анатолий Левин on 11.03.2021.
//

import UIKit
import Alamofire

class FriendsTableViewController: UITableViewController  {
    
    @IBOutlet weak var SearchField: UISearchBar!
        
    private var filteredUsers = [User]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var userGroups = [String: [User]]() {
        didSet {
            users = userGroups.flatMap { $0.value }.sorted{ $0.name < $1.name }
            tableView.reloadData()
        }
    }
    
    private var users = [User]()
    private var sectionTitles = [String]()
    
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            AF.request("https://api.vk.com/method/friends.get",
                       parameters: [
                       "access_token" : Session.shared.token,
                       "user_id" : Session.shared.userId,
                       "order" : "name",
                       "fiends" : "nickname",
                       "v" : "5.68"
                       ]).responseJSON {
                        response in
                        print(response.value)
                       }
            
            
    
        let friend = User(name: "Андрей", age: 39, numberOfFollowers: 5, avatarImageName: "image1", imageView: ["images1","images3","images5","images4","images2","images6"])
        let friend1 = User (name: "Анатолий", age: 9, numberOfFollowers: 5, avatarImageName: "image2", imageView: ["images2","images4","images6"])
        let friend2 = User(name: "Сергей ", age: 3, numberOfFollowers: 5, avatarImageName: "image3", imageView: ["images1","images2","images3"])
        let friend3 = User(name: "Игорь", age: 2, numberOfFollowers: 8, avatarImageName: "image4", imageView: ["images4","images5","images6"])
       
        let users = [friend, friend1, friend2,friend3]
        configureUserGroups(with: users)
        
        tableView.tableFooterView = UIView() 
    }
        private func configureUserGroups(with users: [User]) {
            userGroups = Dictionary(grouping: users, by: { String($0.name.first!)})
            sectionTitles = [String](userGroups.keys)
            sectionTitles = sectionTitles.sorted { $0 < $1}
        }
        
        
        // MARK: - Table view data source

        override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
            return filteredUsers.isEmpty ? sectionTitles : nil
        }
        
        override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return filteredUsers.isEmpty ? sectionTitles[section] : nil
        }
     
        override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            if filteredUsers.isEmpty {
                let sectionTitle = sectionTitles[section]
                return FriendTableViewHeader(reuseIdentifier: sectionTitle)
            } else {
                return nil
            }
        }
        
        override func numberOfSections(in tableView: UITableView) -> Int {
            return filteredUsers.isEmpty ? sectionTitles.count : 1
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if filteredUsers.isEmpty {
                let sectionTitle = sectionTitles[section]
                return userGroups[sectionTitle]?.count ?? 0
            } else {
                return filteredUsers.count
            }
        }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
               users.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
          }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FriendTableViewCell
            
            var user: User? = nil
            if filteredUsers.isEmpty {
                let sectionTitle = sectionTitles[indexPath.section]
                user = userGroups[sectionTitle]?[indexPath.row]
            } else {
                user = filteredUsers[indexPath.row]
            }
            cell.friendNameLabel.text = user!.name
            cell.FriendProfilePhotoImageView.image = UIImage(named: user!.avatarImageName)
            return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueShowPhotos" {
            guard let viewController = segue.destination as? PhotosViewController,
                  let selectedIndexPath = tableView.indexPathForSelectedRow else {
                return
            }
            
            var user: User? = nil
            if filteredUsers.isEmpty {
                let sectionTitle = sectionTitles[selectedIndexPath.section]
                user = userGroups[sectionTitle]?[selectedIndexPath.row]
            } else {
                user = filteredUsers[selectedIndexPath.row]
            }
            viewController.photos = user!.imageView.map { UIImage(named: $0)!}
        }
    }
}

//  MARK: - Segues

extension FriendsTableViewController : UISearchBarDelegate {
    func searchBar(_ searhBar: UISearchBar,textDidChange serchText: String ){
        guard let searchText = searhBar.text, !searchText.isEmpty else {
            clearSearch(searhBar)
            return
        }
        
        filteredUsers = users.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        clearSearch(searchBar)
    }

    private func clearSearch(_ searchBar: UISearchBar){
        searchBar.text = nil
        view.endEditing(true)
        filteredUsers = [User]()
    }
}
