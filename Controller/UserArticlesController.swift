//
//  UserArticlesController.swift
//  chatTogther
//
//  Created by Aries Yang on 2017/11/26.
//  Copyright © 2017年 Susu Liang. All rights reserved.
//

import UIKit
import Firebase

class UserArticlesController: UITableViewController {

    var authorUid: String = " "
    var author: String = " "
    var articles: [Article] = []
    var articleKeys: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(PublishArticleCell.self, forCellReuseIdentifier: "articleCell")
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(done))
        Database.database().reference().observe(.value) { (snapshot) in
            self.articles = []
            
            if let objects = snapshot.children.allObjects as? [DataSnapshot] {
                for object in objects {
                    if let users = object.value as? [String: AnyObject],
                        let currentUser = users[self.authorUid],
                        let firstname = currentUser["firstName"] as? String,
                        let lastname = currentUser["lastName"] as? String,
                        let articles = currentUser["articles"] as? NSDictionary {
                        guard let keys = articles.allKeys as? [String] else { return }
                        self.articleKeys = keys
                        for key in keys {
                            guard
                                let theArticle = articles[key] as? [String: String],
                                let title = theArticle["title"],
                                let content = theArticle["content"],
                                let date = theArticle["date"]
                            else { return }
                            
                            self.articles.insert(Article(id: key, title: title, content: content, date: date, author: firstname + " " + lastname, uid: self.authorUid), at: 0)
                            self.articles.sort() { $0.date > $1.date }
                        }
                        self.tableView.reloadData()
                        
                    }
                }
            }
        }
    }

    @objc func done() {
        navigationController?.popViewController(animated: true)
    }

//    func setUpAuthorNavBar() {
//        let navItem = UINavigationItem(title: author)
//        let cancelImage = UIImage(named: "icon-cross")
//        navItem.leftBarButtonItem = UIBarButtonItem(image: cancelImage, style: .plain, target: self, action: #selector(cancel))
//        authorNavigationBar.setItems([navItem], animated: true)
//    }
//
//    @objc func cancel() {
//        dismiss(animated: true, completion: nil)
//    }


    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = articles[indexPath.row].title
        cell.detailTextLabel?.text = articles[indexPath.row].date
        return cell
    }
}
