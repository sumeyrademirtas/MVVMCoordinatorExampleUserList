//
//  AddUserViewModel.swift
//  MVVMCoordinatorExampleUserList
//
//  Created by Sümeyra Demirtaş on 12/31/24.
//

import Foundation

class AddUserViewModel {
    func addUser(name: String, email: String) {
        CoreDataManager.shared.addUser(name: name, email: email)
    }
}
