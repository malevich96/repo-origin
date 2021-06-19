//
//  NewsViewController.swift
//  VK1_App
//
//  Created by Анатолий Левин on 11.06.2021.
//

import UIKit

class NewsViewController: UIViewController {
    
    
    let networkService = VKNetService()
    
    override func loadView() {
        super.loadView()
        self.view = NewsView()

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkService.getNews(onComplete: { (news) in
            self.view().newsTableView.news = news
            self.view().newsTableView.reloadData()
        }) { (error) in
            print(error)
        }
        title = "Новости"
        

    }
    
    func view() -> NewsView {
        return self.view as! NewsView
    }
}

