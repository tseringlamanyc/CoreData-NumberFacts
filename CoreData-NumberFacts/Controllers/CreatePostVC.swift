//
//  CreatePostVC.swift
//  CoreData-NumberFacts
//
//  Created by Tsering Lama on 4/8/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit

class CreatePostVC: UITableViewController {
    
    @IBOutlet weak var postTitleTF: UITextField!
    @IBOutlet weak var numberFactTF: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    
    private var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePickerView()
        loadUsers()
    }
    
    private func configurePickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    private func loadUsers() {
        users = CoreDataManager.shared.fetchUsers()
    }
    
    @IBAction func submitPressed(_ sender: UIButton) {
        
    }
}

extension CreatePostVC: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return users.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return users[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
}
