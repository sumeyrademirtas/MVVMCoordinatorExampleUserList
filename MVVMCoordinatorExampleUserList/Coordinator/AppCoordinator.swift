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
        CoreDataManager.shared.initializeData() // Örnek kullanıcıları ekle
        firstScreen.coordinator = self
        uiWindow.rootViewController = navigationController
        uiWindow.makeKeyAndVisible()
        navigationController.viewControllers = [firstScreen]
    }

    func showUserDetail(user: CDUser) {
        let detailVC = UserDetailViewController()
        detailVC.user = user
        detailVC.delegate = self // Delegate olarak AppCoordinator atanıyor
        navigationController.pushViewController(detailVC, animated: true)
    }
    
    func showEditScreen(for user: CDUser) {
        let editCoordinator = UserEditCoordinator(navigationController: navigationController)
        editCoordinator.delegate = self // Delegate'i ata
        childCoordinators.append(editCoordinator) // Child coordinators listesine ekle
        editCoordinator.start(user: user) // Başlat
    }
    
    private func updateUser(_ updatedUser: CDUser) {
        CoreDataManager.shared.saveContext()
        refreshUserList()
    }
    
    private func refreshUserList() {
        if let userListVC = navigationController.viewControllers.first as? UserListViewController {
            userListVC.reloadData()
        }
    }
    
    func removeChildCoordinator(_ coordinator: Coordinator) {
        print("Before removing: \(childCoordinators.count) coordinators") // Test
        childCoordinators.removeAll { $0 === coordinator }
        print("After removing: \(childCoordinators.count) coordinators") // Test
    }
}

extension AppCoordinator: UserEditCoordinatorDelegate {
    func userEditCoordinatorDidFinish(_ coordinator: UserEditCoordinator, updatedUser: CDUser?) {
        if let user = updatedUser {
            updateUser(user)
        }
        // Listeyi güncelle
        refreshUserList()
        // Detay ekranını güncelle
        if let detailVC = navigationController.viewControllers.last as? UserDetailViewController {
            detailVC.user = updatedUser
            detailVC.refreshUI()
        }
        removeChildCoordinator(coordinator)
    }
}

extension AppCoordinator: UserDetailViewControllerDelegate {
    func userDetailViewControllerDidRequestEdit(_ viewController: UserDetailViewController, user: CDUser) {
        showEditScreen(for: user)
    }
}
