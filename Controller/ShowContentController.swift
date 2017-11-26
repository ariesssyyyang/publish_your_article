//
//  ShowContentController.swift
//  chatTogther
//
//  Created by Aries Yang on 2017/11/27.
//  Copyright © 2017年 Susu Liang. All rights reserved.
//

import UIKit

class ShowContentController: UIViewController {

    var article: Article = Article(id: " ", title: " ", content: " ", date: " ", author: " ", uid: " ")
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.blue.cgColor
        view.layer.masksToBounds = true
        return view
    }()

    let contentLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 20, y: 100, width: 200, height: 200)
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 1
        label.text = " "
        label.textAlignment = .center
        label.textColor = UIColor.black
        return label
    }()

    lazy var authorButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 80/255, green: 101/255, blue: 161/255, alpha: 1)
        button.setTitle("by:", for: .normal)
        button.frame = CGRect(x: 200, y: 30, width: 80, height: 30)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.addTarget(self, action: #selector(authorAtcs), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "done", style: .plain, target: self, action: #selector(done))
        view.addSubview(contentView)
        setUpContentView()
    }

    @objc func done() {
        navigationController?.popViewController(animated: true)
    }

    @objc func authorAtcs() {
        let authorArticleController = UserArticlesController()
        authorArticleController.authorUid = article.uid
        authorArticleController.author = article.author
        navigationController?.pushViewController(authorArticleController, animated: true)
    }

    func setUpContentView() {
        contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -100).isActive = true
        contentView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -250).isActive = true

        contentView.addSubview(contentLabel)
        contentLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        contentLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        contentLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -10).isActive = true
        contentLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -10).isActive = true
        contentLabel.text = article.content

        contentView.addSubview(authorButton)
        authorButton.setTitle(article.author, for: .normal)
        authorButton.titleLabel?.textAlignment = .center
    }
}
