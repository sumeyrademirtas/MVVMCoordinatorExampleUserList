//
//  UserDetailViewModel.swift
//  MVVMCoordinatorExampleUserList
//
//  Created by Sümeyra Demirtaş on 12/31/24.
//

import Foundation

class UserDetailViewModel {
    private var user: CDUser
    
    init(user: CDUser) {
        self.user = user
    }
    
    func getUserName() -> String {
        return user.name ?? "Unknown Name"
    }
    
    func getUserEmail() -> String {
        return user.email ?? "Unknown Email"
    }
    
    func getUser() -> CDUser {
        return user
    }
    
    func reloadUser() {
        if let updatedUser = CoreDataManager.shared.fetchUser(byEmail: user.email ?? "") {
            self.user = updatedUser
        }
    }
}
