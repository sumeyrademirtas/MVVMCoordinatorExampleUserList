//
//  UserEditViewController.swift
//  MVVMCoordinatorExampleUserList
//
//  Created by Sümeyra Demirtaş on 12/25/24.
//

import UIKit

class UserEditViewController: UIViewController {
    private let viewModel: UserEditViewModel
    private let userEditView = UserEditView()

    init(viewModel: UserEditViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = userEditView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupActions()
        populateFields()
    }

    private func setupActions() {
        userEditView.saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        userEditView.cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
    }

    private func populateFields() {
        userEditView.usernameTextField.text = viewModel.getUserName()
        userEditView.emailTextField.text = viewModel.getUserEmail()
    }

    @objc private func saveTapped() {
        guard let name = userEditView.usernameTextField.text, !name.isEmpty,
              let email = userEditView.emailTextField.text, !email.isEmpty
        else {
            print("Name or email cannot be empty")
            return
        }

        viewModel.updateUser(name: name, email: email)
        navigationController?.popViewController(animated: true)
    }

    @objc private func cancelTapped() {
        navigationController?.popViewController(animated: true)
    }
}
