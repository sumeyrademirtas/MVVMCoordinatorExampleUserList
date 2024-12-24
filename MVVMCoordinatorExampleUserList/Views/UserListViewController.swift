//
//  UserListViewController.swift
//  MVVMCoordinatorExampleUserList
//
//  Created by Sümeyra Demirtaş on 12/24/24.
//

import UIKit

class UserListViewController: UIViewController {
    private let tableView: UITableView = .init()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "User List"

        setupTableView()
    }

    private func setupTableView() {
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }
}

extension UserListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MockData.sampleUsers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let user = MockData.sampleUsers[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        return cell
    }
}

extension UserListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = MockData.sampleUsers[indexPath.row]

        let detailVC = UserDetailViewController()
        detailVC.user = selectedUser

        navigationController?.pushViewController(detailVC, animated: true)
    }
}
