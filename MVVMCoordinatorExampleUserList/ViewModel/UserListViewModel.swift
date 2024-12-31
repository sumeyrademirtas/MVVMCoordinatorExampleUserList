//
//  UserListViewModel.swift
//  MVVMCoordinatorExampleUserList
//
//  Created by Sümeyra Demirtaş on 12/31/24.
//

import Foundation

class UserListViewModel {
    private var users: [CDUser] = []
    
    func fetchUsers() {
        users = CoreDataManager.shared.fetchUsers()
    }
    
    func getUser(at index: Int) -> CDUser? {
        guard index >= 0 && index < users.count else { return nil }
        return users[index]
    }
    
    func numberOfUsers() -> Int {
        return users.count
    }
    
    func deleteUser(at index: Int) {
        guard index >= 0 && index < users.count else { return }
        let userToDelete = users[index]
        CoreDataManager.shared.deleteUser(userToDelete)
        users.remove(at: index)
    }
}
