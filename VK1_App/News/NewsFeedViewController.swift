//
//  NewsFeedViewController.swift
//  VK1_App
//
//  Created by Анатолий Левин on 04.06.2021.
//

import UIKit

@available(iOS 13.0, *)
class NewsFeedViewController: UIViewController {
    
    @IBOutlet weak var newsFeedTableView: UITableView!
    
    var newsArray = [News]()
    var sourseIdArray = [Int]()
    let apiWrapper = VKService()
    var groupsInfoArray = [GroupInfoResponse.GroupInfo]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsFeedTableView.delegate = self
        newsFeedTableView.dataSource = self
        newsFeedTableView.register(UINib(nibName: "NewsFeedTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsFeedTableViewCell")
        newsFeedTableView.separatorStyle = .none
        newsFeedTableView.backgroundColor = .clear
        view.backgroundColor = #colorLiteral(red: 0.7681049705, green: 1, blue: 0.9786186814, alpha: 1)
        
        apiWrapper.getNews { [weak self] news in
            self?.newsArray = news
            DispatchQueue.main.async {
            self?.newsFeedTableView.reloadData()
            }
        }
    }
}


@available(iOS 13.0, *)
extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsFeedTableViewCell", for: indexPath) as! NewsFeedTableViewCell
        let news = newsArray[indexPath.row]
        cell.configure(with: news)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        400
    }
}



