//
//  UserDetailViewController.swift
//  MVVMCoordinatorExampleUserList
//
//  Created by Sümeyra Demirtaş on 12/24/24.
//

import UIKit

class UserDetailViewController: UIViewController {
    var user: User?

    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "User Detail"
        
        // Kullanici bilgilerini gosterecek label
        let label  = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.frame = view.bounds

        
        // Secilen kullanicinin bilgilerini goster
        if let user = user {
            label.text = "Name: \(user.name)\nEmail: \(user.email)"
        } else {
            label.text = "No user selected"
        }
        
        view.addSubview(label)
        
        
        // Do any additional setup after loading the view.
    }
    


}
