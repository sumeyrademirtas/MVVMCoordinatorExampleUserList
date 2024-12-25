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
    var completion: (() -> Void)?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(user: User) {
        let userDetailVC = UserDetailViewController()
        userDetailVC.user = user
        navigationController.pushViewController(userDetailVC, animated: true)
    }
    
    func finish() {
        completion?() // Koordinatör tamamlandığında AppCoordinator'a haber ver
    }
}
