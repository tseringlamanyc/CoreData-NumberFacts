//
//  ViewController.swift
//  CoreData-NumberFacts
//
//  Created by Tsering Lama on 4/8/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit

class PostVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var posts = [Post]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        fetchPosts()
    }
    
    private func configureTableView() {
        tableView.dataSource = self
    }
    
    private func fetchPosts() {
        posts = CoreDataManager.shared.fetchPosts()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let createPostVC = segue.destination as? CreatePostVC else {
            fatalError()
        }
        createPostVC.delegate = self
    }
}

extension PostVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath)
        let aPost = posts[indexPath.row]
        cell.textLabel?.text = "\(aPost.title ?? "") \(aPost.number.description)"
        cell.detailTextLabel?.text = "Posted by: \(aPost.user?.name ?? "")"
        return cell
    }
}

extension PostVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 44
  }
}

extension PostVC: CreatePostDelegate {
    func didCreatePost(createPostVC: CreatePostVC, post: Post) {
        posts.append(post)
    }
}

