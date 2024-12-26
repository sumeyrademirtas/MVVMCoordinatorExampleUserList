//
//  UserListViewController.swift
//  MVVMCoordinatorExampleUserList
//
//  Created by Sümeyra Demirtaş on 12/24/24.
//

import UIKit

class UserListViewController: UIViewController {
    private let tableView: UITableView = .init()
    weak var coordinator: AppCoordinator? // Ekranlar arası geçişi AppCoordinator’a bildirmek için kullanılacak.
    
    private var users: [CDUser] = [] // Core Data'dan gelen kullanıcıları saklamak için dizi // GÜNCELLENDİ

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "User List"

        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Core Data'dan kullanıcıları al // GÜNCELLENDİ
        users = CoreDataManager.shared.fetchUsers() ?? [] // GÜNCELLENDİ
        reloadData() // GÜNCELLENDİ
    }

    private func setupTableView() {
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }

    func reloadData() { // GÜNCELLENDİ
        tableView.reloadData() // GÜNCELLENDİ
    }
}

extension UserListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count // Core Data'dan gelen kullanıcı sayısı // GÜNCELLENDİ
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let user = users[indexPath.row] // GÜNCELLENDİ
        cell.textLabel?.text = user.name // GÜNCELLENDİ
        cell.detailTextLabel?.text = user.email // GÜNCELLENDİ
        return cell
    }
}

extension UserListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = users[indexPath.row] // Core Data'dan gelen kullanıcı // GÜNCELLENDİ
        coordinator?.showUserDetail(user: selectedUser) // GÜNCELLENDİ
    }
}
