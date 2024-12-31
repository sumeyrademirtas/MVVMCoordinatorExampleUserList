//
//  AddUserViewController.swift
//  MVVMCoordinatorExampleUserList
//
//  Created by Sümeyra Demirtaş on 12/26/24.
//

import SnapKit
import UIKit

protocol AddUserViewControllerDelegate: AnyObject {
    func addUserViewControllerDidSave(_ viewController: AddUserViewController, name: String, email: String)
}

class AddUserViewController: UIViewController {
    private let viewModel = AddUserViewModel() // İş mantığını yönetmek için ViewModel
    private let addUserView = AddUserView() // UI bileşenlerini barındıran View
      
    override func loadView() {
        view = addUserView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
    }
    
    private func setupActions() {
        addUserView.saveButton.addTarget(self, action: #selector(didTapSave), for: .touchUpInside)
    }
    
    @objc private func didTapSave() {
        guard let name = addUserView.nameTextField.text, !name.isEmpty,
              let email = addUserView.emailTextField.text, !email.isEmpty
        else {
            showAlert(message: "Please fill in all fields.")
            return
        }
        viewModel.addUser(name: name, email: email)
        navigationController?.popViewController(animated: true)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
