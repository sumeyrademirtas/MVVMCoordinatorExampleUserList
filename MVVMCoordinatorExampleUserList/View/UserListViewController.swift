//
//  UserListViewController.swift
//  MVVMCoordinatorExampleUserList
//
//  Created by Sümeyra Demirtaş on 12/24/24.
//

import UIKit

class UserListViewController: UIViewController {
    private let userListView = UserListView()
    private let viewModel = UserListViewModel()
    weak var coordinator: AppCoordinator?

    override func loadView() {
        view = userListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "User List"
        setupAddButton()
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchUsers()
        reloadData()
    }

    private func setupAddButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddUser))
    }

    @objc private func didTapAddUser() {
        coordinator?.showAddUserScreen()
    }

    private func setupTableView() {
        userListView.tableView.dataSource = self
        userListView.tableView.delegate = self
    }

    func reloadData() {
        userListView.tableView.reloadData()
    }
}

extension UserListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfUsers()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        if let user = viewModel.getUser(at: indexPath.row) {
            cell.textLabel?.text = user.name
            cell.detailTextLabel?.text = user.email
        }
        return cell
    }
}

extension UserListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedUser = viewModel.getUser(at: indexPath.row) {
            coordinator?.showUserDetail(user: selectedUser)
        }
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteUser(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
