//
//  AllFriendsTableViewController.swift
//  VK1_App
//
//  Created by Анатолий Левин on 11.03.2021.
//

/*import UIKit

struct AllFriendsTable {
    let char: String
}

/*struct User: Equatable {
    var name:  String
    var image:  UIImage
}

class AllFriendsTableViewController: UITableViewController {
    
    var selectedUsers: User?
    
    private let cellReuseIdentifier = "FriendCell"
    override func viewDidLoad(){
        super.viewDidLoad()
        tableView.register(UINib(nibName: "FriendTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
    }
    
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
    
    let user1 = User(name: "Сергей Рзаев", image: #imageLiteral(resourceName: "image3"))
    let user2 = User(name: "Анатолий Левин", image: #imageLiteral(resourceName: "image2"))
    let user3 = User(name: "Игорь Зверев", image: #imageLiteral(resourceName: "image4"))
    let user4 = User(name: "Александр Филин", image: #imageLiteral(resourceName: "image1"))
    let user5 = User(name: "Андрей Ширяев", image: #imageLiteral(resourceName: "image3"))

    private func configureUserGroups(with users: [User]) {
        userGroups = Dictionary(grouping: users, by: { String($0.name.first!)})
        sectionTitles = [String](userGroups.keys)
        sectionTitles = sectionTitles.sorted { $0 < $1}
    }
    
   // tableView.tableFooterView = UIView() {}
    
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

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier", for: indexPath) as! FriendTableViewCell
        let user: User? = nil
        _ = sectionTitles[indexPath.section]
        _ = filteredUsers[indexPath.row]
        cell.titleLabel.text = user!.name
        cell.photoImageView.image = user?.image
        cell.showDisclosureArrow = true
        return cell
    }
}
//    override func prepare( for segue: UIStoryboardSegue, sender: Any?) {
//      if segue.identifier == "segueShowPhoto" {
//        guard let viewController = segue.destination as? FotoViewController,
//              let selectedIndexPath = tableView.indexPathForSelectedRow else {
//            return
//       }
        
//        var user: User? = nil
//        if filteredUsers.isEmpty {
//            let sectionTitle = sectionTitles[selectedIndexPath.section]
//            user = userGroups[selectedIndexPath.row]
//        } else {
//            user = filteredUsers[selectedIndexPath.row]
//        }
//        viewController.user = User
//      }
//    }
//}

//extension AllFriendsTableViewController : UISearchBarDelegate {
//    func searchBar(_ searhBar: UISearchBar,textDidChange serchText: String){
//        guard let searchText = searhBar.text, !searchText.isEmpty else {
//           clearSearch(searhBar)
//            return
//        }
//        filteredUsers = users.filter { $0.name.lowercased() .contains(searchText) }
//    }

//    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        searchBar.setShowsCancelButton(true, animated: true)
//    }

//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        searchBar.setShowsCancelButton(false, animated: true)
//    }

//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//view.endEditing(true)
//   }
    
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        clearSearch(searchBar)
//    }

//    private func clearSearch(_ searchBar: UISearchBar){
//        searchBar.text = nil
//        view.endEditing(true)
//        filteredUsers = [User]()
//    }
 //}*/*/
