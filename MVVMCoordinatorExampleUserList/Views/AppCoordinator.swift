//
//  AppCoordinator.swift
//  MVVMCoordinatorExampleUserList
//
//  Created by Sümeyra Demirtaş on 12/25/24.
//

import Foundation
import UIKit

class AppCoordinator {
    let uiWindow: UIWindow
    let navigationController = UINavigationController()
    let firstScreen = UserListViewController()
    
    init (windowScene: UIWindowScene) {
        self.uiWindow = UIWindow(windowScene: windowScene)
    }
    
    func start() {
        firstScreen.coordinator = self
        uiWindow.rootViewController = navigationController
        uiWindow.makeKeyAndVisible()
        navigationController.viewControllers = [firstScreen]
        
    }
    
    func showUserDetail(user: User) {
        let detailVC = UserDetailViewController()
        detailVC.user = user
        navigationController.pushViewController(detailVC, animated: true)
    }
}
