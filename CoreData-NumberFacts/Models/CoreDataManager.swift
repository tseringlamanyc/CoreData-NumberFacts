//
//  CoreDataManager.swift
//  CoreData-NumberFacts
//
//  Created by Tsering Lama on 4/9/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    
    // singleton
    static let shared = CoreDataManager()
    private init() {}
    
    private var users = [User]()  // NSManagedObject
    
    private var posts = [Post]()
    
    // access to the persistence container to app delegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    // viewContext is of type NSManagedObjectContext
    
    // CRUD
    public func createUser(name: String, dob: Date) -> User {
        let user = User(entity: User.entity(), insertInto: context)
        user.name = name
        user.dob = dob
        
        // save changes to the NSMangedObjectContext (ie: Filemanager)
        do {
            try context.save()  // NSMangedObjectContext
        } catch {
            print("error saving user: \(error)")
        }
        return user
    }
    
    public func fetchUser() -> [User] {
        do {
            users = try context.fetch(User.fetchRequest())  // fetchRequest gets all the objects from coredata (NSFetchRequest) 
            // NSPredicate to filter core data objects during fetching
        } catch {
            print("Error fetching users: \(error)")
        }
        return users
    }
    
}
