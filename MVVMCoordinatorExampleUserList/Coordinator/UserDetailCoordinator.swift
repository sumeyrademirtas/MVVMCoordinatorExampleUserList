//
//  UserDetailCoordinator.swift
//  MVVMCoordinatorExampleUserList
//
//  Created by Sümeyra Demirtaş on 12/25/24.
//

import UIKit

class UserDetailCoordinator: Coordinator {
    func start() {}

    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start(user: CDUser) {
        let viewModel = UserDetailViewModel(user: user) // ViewModel oluştur
        let userDetailVC = UserDetailViewController(viewModel: viewModel) // ViewModel'i ilet
        navigationController.pushViewController(userDetailVC, animated: true)
    }

    func showEditScreen(for user: CDUser) {
        let editCoordinator = UserEditCoordinator(navigationController: navigationController)
        editCoordinator.start(user: user)
    }
}

extension UserDetailCoordinator: UserDetailViewControllerDelegate {
    func userDetailViewControllerDidRequestEdit(_ viewController: UserDetailViewController, user: CDUser) {
        showEditScreen(for: user)
    }
}
