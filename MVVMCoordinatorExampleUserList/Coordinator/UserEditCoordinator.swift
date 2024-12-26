//
//  UserEditCoordinator.swift
//  MVVMCoordinatorExampleUserList
//
//  Created by Sümeyra Demirtaş on 12/25/24.
//

import Foundation
import UIKit

protocol UserEditCoordinatorDelegate: AnyObject {
    func userEditCoordinatorDidFinish(_ coordinator: UserEditCoordinator, updatedUser: CDUser?)
} // Bu protokol, AppCoordinator’a “işim bitti, kullanıcı verisini sana veriyorum” diyecek.

class UserEditCoordinator: Coordinator {
    weak var delegate: UserEditCoordinatorDelegate?

    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {}

    func start(user: CDUser) {
        print("UserEditCoordinator started") // Test
        let userEditVC = UserEditViewController()
        userEditVC.user = user
        userEditVC.delegate = self // Delegate'i ata
        print("Delegate assigned: \(self)") // Test
        navigationController.pushViewController(userEditVC, animated: true)
    }

    func finish(updatedUser: CDUser? = nil) {
        navigationController.popViewController(animated: true)
        delegate?.userEditCoordinatorDidFinish(self, updatedUser: updatedUser)
    }
}

extension UserEditCoordinator: UserEditViewControllerDelegate {
    func userEditViewControllerDidSave(_ viewController: UserEditViewController, updatedUser: CDUser) {
        print("Delegate save çağrıldı!") // Test
        finish(updatedUser: updatedUser)
    }

    func userEditViewControllerDidCancel(_ viewController: UserEditViewController) {
        print("Delegate cancel çağrıldı!") // Test
        finish()
    }
}
