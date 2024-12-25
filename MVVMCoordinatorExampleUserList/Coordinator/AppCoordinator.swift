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

    func showUserDetail(user: User) {
        let detailCoordinator = UserDetailCoordinator(navigationController: navigationController)
        
        // Koordinatör tamamlanınca listeden kaldır
        detailCoordinator.completion = { [weak self] in
            self?.removeChildCoordinator(detailCoordinator)
        }
        
        childCoordinators.append(detailCoordinator)
        detailCoordinator.start(user: user)
    }
    
    func removeChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.removeAll { $0 === coordinator }
    }
}
