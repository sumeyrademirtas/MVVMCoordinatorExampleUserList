//
//  UserEditViewController.swift
//  MVVMCoordinatorExampleUserList
//
//  Created by Sümeyra Demirtaş on 12/25/24.
//

import UIKit

protocol UserEditViewControllerDelegate: AnyObject {
    func userEditViewControllerDidSave(_ viewController: UserEditViewController, updatedUser: CDUser)
    func userEditViewControllerDidCancel(_ viewController: UserEditViewController)
}

class UserEditViewController: UIViewController {
    weak var delegate: UserEditViewControllerDelegate?
    var user: CDUser?
    
    // emailTextField
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 18)
        return textField
    }()
    
    // usernameTextField
    private let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 18)
        return textField
    }()
    
    // saveButton
    private let saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        return button
    }()
    
    // cancelButton
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemRed
        return button
    }()
    
    // stackView
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Edit User"
        
        addSubviews()
        setupView()
        setupActions()
        populateFields()
    }
    
    private func addSubviews() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(usernameTextField)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(saveButton)
        stackView.addArrangedSubview(cancelButton)
    }
    
    private func setupView() {
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).inset(20)
        }
    }
    
    private func setupActions() {
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
    }
    
    private func populateFields() {
        if let user = user {
            usernameTextField.text = user.name
            emailTextField.text = user.email
        }
    }

    @objc private func saveTapped() {
        guard let name = usernameTextField.text, !name.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let user = user else {
            print("Name or email cannot be empty")
            return
        }

        CoreDataManager.shared.updateUser(user, name: name, email: email)
        delegate?.userEditViewControllerDidSave(self, updatedUser: user)
    }

    @objc private func cancelTapped() {
        print("Cancel button tapped") // Test
        delegate?.userEditViewControllerDidCancel(self)
    }
}
