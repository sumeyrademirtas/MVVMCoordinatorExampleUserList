//
//  UserEditViewModel.swift
//  MVVMCoordinatorExampleUserList
//
//  Created by Sümeyra Demirtaş on 12/31/24.
//

import Foundation

import Foundation

class UserEditViewModel {
    private var user: CDUser

    init(user: CDUser) {
        self.user = user
    }

    func getUserName() -> String {
        return user.name ?? ""
    }

    func getUserEmail() -> String {
        return user.email ?? ""
    }

    func updateUser(name: String, email: String) {
        CoreDataManager.shared.updateUser(user, name: name, email: email)
    }
}
