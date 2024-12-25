//
//  UserEditCoordinator.swift
//  MVVMCoordinatorExampleUserList
//
//  Created by Sümeyra Demirtaş on 12/25/24.
//

import Foundation
import UIKit

class UserEditCoordinator: Coordinator {
    var navigationController: UINavigationController
    var completion: (() -> Void)?

    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let userEditVC = UserEditViewController()
        navigationController.pushViewController(userEditVC, animated: true)
        
        userEditVC.onSave = { [weak self] user in
            print("User saved: \(user)")
            self?.finish()
        }
        
        userEditVC.onCancel = { [weak self] in
            print("User edit cancelled")
            self?.finish()
        }
        
    }
    
    func finish() {
        navigationController.popViewController(animated: true)
        completion?()
    }
    
    
}
