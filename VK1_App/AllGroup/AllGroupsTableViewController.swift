//
//  AllGroupsTableViewController.swift
//  VK1_App
//
//  Created by Анатолий Левин on 09.04.2021.
//

import UIKit
import Alamofire
import AlamofireImage
import RealmSwift

class AllGroupsTableViewController: UITableViewController {
   
    @IBOutlet weak var SearchField: UISearchBar!
    
    private var groups = [VKGroup]()
    private var filteredGroups = [VKGroup]() {
        didSet {
            tableView.reloadData()
        }
    }
    private var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         requestData()
        navigationItem.rightBarButtonItem = nil
        tableView.tableFooterView = UIView()
    }
    
    private func requestData() {
         VKService.instance.loadGroups { result in
             switch result {
             case .success:
                 self.fetchCachedData()
             case .failure(let error):
                 self.fetchCachedData()
                 print(error)
             }
         }
     }

     private func fetchCachedData() {
         guard let groups = RealmService.instance.fetchObjects(VKGroup.self) else {
             return
         }
         self.groups = groups
        self.configureRealmNotifications()
        }

        private func configureRealmNotifications() {
            guard let realm = try? Realm() else { return }
            token = realm.objects(VKGroup.self).observe({ [weak self] changes in
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
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredGroups.isEmpty ? groups.count : filteredGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "GroupTableViewCell", for: indexPath) as! GroupTableViewCell
            let group = filteredGroups.isEmpty ? groups[indexPath.row] : filteredGroups[indexPath.row]
            let avatar = URL(string: group.avatarUrl)!
            cell.titleLabel.text = group.groupName
            cell.CommunityPhotosImageView.af.setImage(withURL: avatar)
            cell.CommunityPhotosImageView.setNeedsDisplay()
            return cell
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
               tableView.deselectRow(at: indexPath, animated: true)
            return
           }
    
    /*
    @IBAction func addGroups(segue: UIStoryboardSegue) {
        if segue.identifier == "addGroups" {
            let otherGroupsTableViewController = segue.source as! OtherGroupsTableViewController

            if let indexPath = otherGroupsTableViewController.tableView.indexPathForSelectedRow {
                let otherGroups = otherGroupsTableViewController.filteredGroups.isEmpty ? otherGroupsTableViewController.groups : otherGroupsTableViewController.filteredGroups
                let group = otherGroups[indexPath.row]
                if !groups.contains(group) {
                    groups.append(group)
                    tableView.reloadData()
                }
            }
        }
    }
    */
    
        func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return filteredGroups.isEmpty ? true : false
    }
    
        func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
           return filteredGroups.isEmpty ? true : false
       }
       
       override func tableView(_ tableView: UITableView,
                               commit editingStyle: UITableViewCell.EditingStyle,
                               forRowAt indexPath: IndexPath) {
           if editingStyle == .delete {
               groups.remove(at: indexPath.row)
               tableView.deleteRows(at: [indexPath], with: .fade)
           }
       }
   }

   extension AllGroupsTableViewController: UISearchBarDelegate {
       func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           guard let searchText = searchBar.text, !searchText.isEmpty else {
               clearSearch(searchBar)
               return
           }
           filteredGroups = groups.filter { $0.groupName.contains(searchText) }
       }
       
       func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
           searchBar.setShowsCancelButton(true, animated: true)
       }
       
       func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
           searchBar.setShowsCancelButton(false, animated: true)
       }
       
       func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
           view.endEditing(true)
       }
       
       func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
           clearSearch(searchBar)
       }
       
       private func clearSearch(_ searchBar: UISearchBar) {
           searchBar.text = nil
           view.endEditing(true)
           filteredGroups = [VKGroup]()
       }
   }
