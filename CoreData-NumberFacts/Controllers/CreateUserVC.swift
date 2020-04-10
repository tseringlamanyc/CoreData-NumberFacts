//
//  CreateUserVC.swift
//  CoreData-NumberFacts
//
//  Created by Tsering Lama on 4/8/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit

protocol CreateUserVCDelegate: AnyObject {
    func didCreateUser(createUserVC: CreateUserVC, user: User)
}

class CreateUserVC: UITableViewController {
    
    @IBOutlet weak var userTF: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    weak var delegate: CreateUserVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.maximumDate = Date() // todays date
    }
    
    @IBAction func submitPressed(_ sender: UIButton) {
        
        guard let userName = userTF.text, !userName.isEmpty else {
            print("Missing username")
            return
        }
        
        let date = datePicker.date
        
        // create a user
        let user = CoreDataManager.shared.createUser(name: userName, dob: date)
        
        // set delegate
        delegate?.didCreateUser(createUserVC: self, user: user)
        dismiss(animated: true)
    }
}
