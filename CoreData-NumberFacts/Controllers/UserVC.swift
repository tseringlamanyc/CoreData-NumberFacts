//
//  UserVC.swift
//  CoreData-NumberFacts
//
//  Created by Tsering Lama on 4/8/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit

class UserVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var users = [User]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        loadUsers()
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func loadUsers() {
        users = CoreDataManager.shared.fetchUsers()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createUserSegue" {
            guard let createUserVC = segue.destination as? CreateUserVC else {
                fatalError()
            }
            createUserVC.delegate = self
        }
    }
    
}

extension UserVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        let aUser = users[indexPath.row]
        cell.textLabel?.text = aUser.name
        return cell
    }
}

extension UserVC: UITableViewDelegate {
    
}

extension UserVC: CreateUserVCDelegate {
    func didCreateUser(createUserVC: CreateUserVC, user: User) {
        users.append(user)  // adds to tableView 
        
    }
}
