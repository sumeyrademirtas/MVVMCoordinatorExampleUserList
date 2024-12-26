//
//  AddUserViewController.swift
//  MVVMCoordinatorExampleUserList
//
//  Created by Sümeyra Demirtaş on 12/26/24.
//

import UIKit
import SnapKit

protocol AddUserViewControllerDelegate: AnyObject {
    func addUserViewControllerDidSave(_ viewController: AddUserViewController, name: String, email: String)
}

class AddUserViewController: UIViewController {
    weak var delegate: AddUserViewControllerDelegate?
    
    // Name TextField
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Name"
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 18)
        return textField
    }()
    
    // Email TextField
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Email"
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 18)
        return textField
    }()
    
    // Save Button
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        return button
    }()
    
    // StackView
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Add User"
        
        setupUI()
        setupActions()
    }
    
    private func setupUI() {
        // Add stack view to the main view
        view.addSubview(stackView)
        
        // Add text fields and button to the stack view
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(saveButton)
        
        // Layout constraints using SnapKit
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        saveButton.snp.makeConstraints { make in
            make.height.equalTo(44)
        }
    }
    
    private func setupActions() {
        saveButton.addTarget(self, action: #selector(didTapSave), for: .touchUpInside)
    }
    
    @objc private func didTapSave() {
        guard let name = nameTextField.text, !name.isEmpty,
              let email = emailTextField.text, !email.isEmpty else {
            showAlert(message: "Please fill in all fields.")
            return
        }
        delegate?.addUserViewControllerDidSave(self, name: name, email: email)
        navigationController?.popViewController(animated: true)
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
