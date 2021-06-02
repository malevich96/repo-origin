//
//  FriendsTableViewController.swift
//  VK1_App
//
//  Created by Анатолий Левин on 11.03.2021.
//

import UIKit
import Alamofire
import AlamofireImage
<<<<<<< Updated upstream
=======
import RealmSwift

>>>>>>> Stashed changes

class FriendsTableViewController: UITableViewController  {
    
    @IBOutlet weak var SearchField: UISearchBar!
        
    private var filteredUsers = [VKUser]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var userGroups = [String: [VKUser]]() {
        didSet {
            users = userGroups.flatMap { $0.value } .sorted { $0.lastName < $1.lastName }
            tableView.reloadData()
        }
    }
    
    private var users = [VKUser]()
    private var sectionTitles = [String]()
    private var token: NotificationToken?
    
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            
<<<<<<< Updated upstream
       // let friend = User(name: "Андрей", age: 39, numberOfFollowers: 5, avatarImageName: "image1", imageView: ["images1","images3","images5","images4","images2","images6"])
       // let friend1 = User (name: "Анатолий", age: 9, numberOfFollowers: 5, avatarImageName: "image2", imageView: ["images2","images4","images6"])
       // let friend2 = User(name: "Сергей ", age: 3, numberOfFollowers: 5, avatarImageName: "image3", imageView: ["images1","images2","images3"])
      //  let friend3 = User(name: "Игорь", age: 2, numberOfFollowers: 8, avatarImageName: "image4", imageView: ["images4","images5","images6"])
       
      //  let users = [friend, friend1, friend2,friend3]
      //  configureUserGroups(with: users)
        
=======
>>>>>>> Stashed changes
        requestData()
        tableView.tableFooterView = UIView() 
    }
    
    private func requestData() {
        VKService.instance.loadFriends { result in
            switch result {
<<<<<<< Updated upstream
            case .success(let users):
                self.users = users
                self.configureUserGroups(with: users)
                self.tableView.reloadData()
            case .failure(let error):
=======
            case .success:
                self.fetchCachedData()
            case .failure(let error):
                self.fetchCachedData()
>>>>>>> Stashed changes
                print(error)
            }
        }
    }
<<<<<<< Updated upstream
=======
    
    private func fetchCachedData() {
        guard let users = RealmService.instance.fetchObjects(VKUser.self) else {
            return
        }
        self.users = users
        self.configureUserGroups(with: users)
        self.configureRealmNotifications()
    }
    
    private func configureRealmNotifications() {
        guard let realm = try? Realm() else { return }
        token = realm.objects(VKUser.self).observe({ [weak self] changes in
            switch changes {
            case .initial:
                self?.tableView.reloadData()
            case .update(_,
                         deletions: let deletions,
                         insertions: let insertions,
                         modifications: let modifications):
                self?.tableView.beginUpdates()
                self?.tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                self?.tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                     with: .automatic)
                self?.tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
                                     with: .automatic)
                self?.tableView.endUpdates()
            case .error(let error):
                fatalError(error.localizedDescription)
            }
        })
    }
    
>>>>>>> Stashed changes
        private func configureUserGroups(with users: [VKUser]) {
            for user in users {
                let userKey = String(user.lastName.prefix(1))
                if var userGroup = userGroups[userKey] {
                    userGroup.append(user)
                    userGroups[userKey] = userGroup
                } else {
                    userGroups[userKey] = [user]
                }
            }
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
            
            var user: VKUser? = nil
            if filteredUsers.isEmpty {
                let sectionTitle = sectionTitles[indexPath.section]
                user = userGroups[sectionTitle]?[indexPath.row]
            } else {
                user = filteredUsers[indexPath.row]
            }
             let avatarUrl = URL(string: user!.avatarUrl)!
             cell.friendNameLabel.text = String(format: "%@ %@", user!.firstName, user!.lastName)
             cell.FriendProfilePhotoImageView.af.setImage(withURL: avatarUrl)
             cell.FriendProfilePhotoImageView.setNeedsDisplay()
             return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueShowPhotos" {
            guard let viewController = segue.destination as? FriendPhotosCollectionViewController,
                  let selectedIndexPath = tableView.indexPathForSelectedRow else {
                return
            }
            
            var user: VKUser? = nil
            if filteredUsers.isEmpty {
                let sectionTitle = sectionTitles[selectedIndexPath.section]
                user = userGroups[sectionTitle]?[selectedIndexPath.row]
            } else {
                user = filteredUsers[selectedIndexPath.row]
            }
<<<<<<< Updated upstream
            viewController.user = user
=======
            viewController.userId = user?.userId ?? 1
>>>>>>> Stashed changes
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
        
        filteredUsers = users.filter { $0.lastName.lowercased().contains(searchText.lowercased()) ||
                   $0.firstName.lowercased().contains(searchText.lowercased()) }
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
        filteredUsers = [VKUser]()
    }
}
