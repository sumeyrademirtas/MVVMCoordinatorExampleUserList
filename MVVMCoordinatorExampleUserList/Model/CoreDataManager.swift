//
//  CoreDataManager.swift
//  MVVMCoordinatorExampleUserList
//
//  Created by Sümeyra Demirtaş on 12/26/24.
//

import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MVVMCoordinatorExampleUserList")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
        return container
    }()

    private var context: NSManagedObjectContext { persistentContainer.viewContext }

    func fetchUser(byEmail email: String) -> CDUser? {
        let fetchRequest: NSFetchRequest<CDUser> = CDUser.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)

        do {
            let users = try context.fetch(fetchRequest)
            return users.first
        } catch {
            print("Error fetching user: \(error)")
            return nil
        }
    }

    func fetchUsers() -> [CDUser] {
        let fetchRequest: NSFetchRequest<CDUser> = CDUser.fetchRequest()

        do {
            let users = try context.fetch(fetchRequest)
            return users
        } catch {
            print("Error fetching users: \(error)")
            return []
        }
    }

    func addUser(name: String, email: String) {
        let user = CDUser(context: context) // CDUser olarak güncellendi
        user.name = name
        user.email = email
        saveContext()
    }

    func updateUser(_ user: CDUser, name: String, email: String) {
        user.name = name
        user.email = email
        saveContext()
    }

    func deleteUser(_ user: CDUser) {
        context.delete(user)
        saveContext()
    }

    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed to save context: \(error)")
            }
        }
    }
}
