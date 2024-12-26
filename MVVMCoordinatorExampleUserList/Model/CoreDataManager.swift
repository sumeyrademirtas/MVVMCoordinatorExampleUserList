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

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
//    func initializeData() {
//        // Eğer hiç kullanıcı yoksa örnek kullanıcılar ekle
//        if fetchUsers().isEmpty {
//            addUser(name: "John Doe", email: "john@example.com")
//            addUser(name: "Jane Smith", email: "jane@example.com")
//            addUser(name: "Emily Johnson", email: "emily@example.com")
//        }
//    }

    // Kullanıcıları getir
    func fetchUser(byEmail email: String) -> CDUser? {
        let fetchRequest: NSFetchRequest<CDUser> = CDUser.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)

        do {
            let users = try context.fetch(fetchRequest)
            return users.first // İlk eşleşen kullanıcıyı döndür
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

    // Kullanıcı ekle
    func addUser(name: String, email: String) {
        let user = CDUser(context: context) // CDUser olarak güncellendi
        user.name = name
        user.email = email
        saveContext()
    }

    // Kullanıcı güncelle
    func updateUser(_ user: CDUser, name: String, email: String) {
        user.name = name
        user.email = email
        saveContext()
    }
    
    func deleteUser(_ user: CDUser) {
        context.delete(user) // Core Data'dan sil
        saveContext()        // Değişiklikleri kaydet
    }

    // Değişiklikleri kaydet
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Failed to save context: \(error)")
            }
        }
    }
}
