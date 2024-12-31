//
//  AppCoordinator.swift
//  MVVMCoordinatorExampleUserList
//
//  Created by Sümeyra Demirtaş on 12/25/24.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    let uiWindow: UIWindow
    var navigationController: UINavigationController
    let firstScreen = UserListViewController()

    var childCoordinators: [Coordinator] = []

    init(windowScene: UIWindowScene) {
        self.uiWindow = UIWindow(windowScene: windowScene)
        self.navigationController = UINavigationController()
    }

    func start() {
        firstScreen.coordinator = self
        uiWindow.rootViewController = navigationController
        uiWindow.makeKeyAndVisible()
        navigationController.viewControllers = [firstScreen]
    }

    func showUserDetail(user: CDUser) {
        let viewModel = UserDetailViewModel(user: user)
        let detailVC = UserDetailViewController(viewModel: viewModel)
        detailVC.delegate = self // Delegate atanıyor mu?
        navigationController.pushViewController(detailVC, animated: true)
    }

    func showEditScreen(for user: CDUser) {
        let editCoordinator = UserEditCoordinator(navigationController: navigationController)
        editCoordinator.delegate = self // Delegate'i ata
        childCoordinators.append(editCoordinator) // Child coordinators listesine ekle
        editCoordinator.start(user: user) // Başlat
    }

    func removeChildCoordinator(_ coordinator: Coordinator) {
        print("Before removing: \(childCoordinators.count) coordinators") // Test
        childCoordinators.removeAll { $0 === coordinator }
        print("After removing: \(childCoordinators.count) coordinators") // Test
    }

    func showAddUserScreen() {
        let addUserVC = AddUserViewController()
        navigationController.pushViewController(addUserVC, animated: true)
    }
}

extension AppCoordinator: UserEditCoordinatorDelegate {
    func userEditCoordinatorDidFinish(_ coordinator: UserEditCoordinator, updatedUser: CDUser?) {
        // Child koordinatörün işini tamamladığını belirtiyor ve bellekten temizlenmesi için kaldırıyoruz.
        // Bu, hafıza sızıntılarını önlemek ve koordinatör yapısını temiz tutmak için gereklidir.
        removeChildCoordinator(coordinator)
    }
}

extension AppCoordinator: UserDetailViewControllerDelegate {
    func userDetailViewControllerDidRequestEdit(_ viewController: UserDetailViewController, user: CDUser) {
        showEditScreen(for: user)
    }
}

extension AppCoordinator: AddUserViewControllerDelegate {
    func addUserViewControllerDidSave(_ viewController: AddUserViewController, name: String, email: String) {}
}
