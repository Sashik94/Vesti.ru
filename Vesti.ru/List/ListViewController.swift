//
//  ListViewController.swift
//  Vesti.ru
//
//  Created by Александр Осипов on 02.07.2020.
//  Copyright © 2020 Александр Осипов. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var titleNavigationItem: UINavigationItem!
    @IBOutlet weak var listTableView: UITableView!
    
    var items: [Item] = []
    var categories: [String] = []
    var currentCategory: String?
    
    let myRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    @objc private func refresh(sender: UIRefreshControl) {
        loadRSS()
        sender.endRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadRSS()
        listTableView.refreshControl = myRefreshControl
    }
    
    func loadRSS() {
        
        let url = URL(string: "https://www.vesti.ru/vesti.rss")!
        
        Parser.parse(xmlURL: url, onSuccess: { (channel) in
            if let currentCategory = self.currentCategory, currentCategory != "Все" {
                self.items = channel.items.filter({ $0.categories! == currentCategory })
                self.titleNavigationItem.title = currentCategory
            } else {
                self.items = channel.items
                self.fillingCategories(items: self.items)
                self.titleNavigationItem.title = "Вести.Ru"
            }
            self.listTableView.reloadData()
        }, onNotFound: {
            print("onNotFound")
        }, onFailure: { (error) in
        })
    }
    
    func getPubDateString(pubDate: Date) ->String {
        let format = DateFormatter()
        format.dateFormat = "yyyy/M/d HH:mm"
        
        let pubDateString = format.string(from: pubDate)
        return pubDateString
    }
    
    func fillingCategories(items: [Item]) {
        categories = []
        categories.append("Все")
        for item in items {
            if categories.filter({ $0 == item.categories! }).count == 0 {
                categories.append(item.categories!)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Full" {
            let listTableViewCell = sender as! UITableViewCell
            let indexPath = listTableView.indexPath(for: listTableViewCell)!
            let RVC = segue.destination as! RecordViewController
            RVC.item = items[indexPath.row]
        } else if segue.identifier == "Selection" {
            let SVC = segue.destination as! SelectionViewController
            SVC.categories = categories
            SVC.currentCategory = { currentCategory in
                self.dismiss(animated: true) {
                    self.currentCategory = currentCategory
                    self.loadRSS()
                }
            }
        }
    }
    
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ListTableViewCell
        
        let item = self.items[indexPath.row]
        cell.titleLabel.text = item.title

        if let pubDate = item.pubDate {
            cell.pubDateLabel.text = getPubDateString(pubDate: pubDate)
        }
        
        return cell
    }
}
