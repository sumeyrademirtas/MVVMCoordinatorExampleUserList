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
    
    init (windowScene: UIWindowScene) {
        self.uiWindow = UIWindow(windowScene: windowScene)
        self.navigationController = UINavigationController()
    }
    
    func start() {
        firstScreen.coordinator = self
        uiWindow.rootViewController = navigationController
        uiWindow.makeKeyAndVisible()
        navigationController.viewControllers = [firstScreen]
        
    }
    
//    func showUserDetail(user: User) {
//        let detailVC = UserDetailViewController()
//        detailVC.user = user
//        navigationController.pushViewController(detailVC, animated: true)
//    }
    
    func showUserDetail(user: User) {
           let detailCoordinator = UserDetailCoordinator(navigationController: navigationController)
           detailCoordinator.start(user: user)
       }
}
