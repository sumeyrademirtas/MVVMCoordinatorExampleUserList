//
//  UserDetailViewController.swift
//  MVVMCoordinatorExampleUserList
//
//  Created by Sümeyra Demirtaş on 12/24/24.
//

import SnapKit
import UIKit

protocol UserDetailViewControllerDelegate: AnyObject {
    func userDetailViewControllerDidRequestEdit(_ viewController: UserDetailViewController, user: CDUser)
}

class UserDetailViewController: UIViewController {
    weak var delegate: UserDetailViewControllerDelegate?
    private let viewModel: UserDetailViewModel
    private let userDetailView = UserDetailView()

    init(viewModel: UserDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = userDetailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "User Detail"
        setupActions()
        refreshUI()
    }

    private func setupActions() {
        userDetailView.editButton.addTarget(self, action: #selector(didTapEdit), for: .touchUpInside)
    }

    private func refreshUI() {
        userDetailView.nameLabel.text = viewModel.getUserName()
        userDetailView.emailLabel.text = viewModel.getUserEmail()
    }

    @objc private func didTapEdit() {
        let user = viewModel.getUser() // Kullanıcıyı al
        delegate?.userDetailViewControllerDidRequestEdit(self, user: user)
    }
}
