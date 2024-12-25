//
//  UserDetailViewController.swift
//  MVVMCoordinatorExampleUserList
//
//  Created by Sümeyra Demirtaş on 12/24/24.
//

import UIKit
import SnapKit

class UserDetailViewController: UIViewController {
    var user: User?
    
    // nameLabel
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()

    // emailLabel
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    // profileImage
    private let profileImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "person.circle"))
        image.tintColor = .gray
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.layer.cornerRadius = 50
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "User Detail"
        
        // Single Responsibility Principle (SRP). her seyi viewDidLoad icinde yapmak yerine ayri ayri funclar yazip onlari cagirmak daha uygun.
        
        addSubviews()
        setupView()
        setupUserDetails()


    }
    
    private func addSubviews() {
        // Alt görünümleri view'a ekliyoruz
        view.addSubview(profileImage)
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        
    }
    
    private func setupView() {

        profileImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(100)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }

        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func setupUserDetails() {
           // Kullanıcı bilgilerini label'lara ayarla
           if let user = user {
               nameLabel.text = user.name
               emailLabel.text = user.email
           } else {
               nameLabel.text = "No user selected"
               emailLabel.text = ""
           }
       }
}
