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
            print("Error saving user: \(error)")
        }
        return user
    }
    
    public func fetchUsers() -> [User] {
        do {
            users = try context.fetch(User.fetchRequest())  // fetchRequest gets all the objects from coredata (NSFetchRequest) 
            // NSPredicate to filter core data objects during fetching
        } catch {
            print("Error fetching users: \(error)")
        }
        return users
    }
    
    public func createPost(user: User, numberFact: Double, title: String) -> Post {
        let post = Post(entity: Post.entity(), insertInto: context)
        post.number = numberFact
        post.title = title
        
        // create relationship between post and user
        post.user = user
        
        do {
            try context.save()
        } catch {
            print("Error saving post: \(post)")
        }
        return post
    }
    
    public func fetchPosts() -> [Post] {
        do {
            posts = try context.fetch(Post.fetchRequest())
        } catch {
            print("Error fetching post: \(error)")
        }
        return posts
    }
    
    public func deletePost(post: Post) {
        context.delete(post)
        
        do {
            try context.save()
        } catch {
            print("Failed to delete post: \(error)")
        }
    }
}
