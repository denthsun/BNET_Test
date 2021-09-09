//
//  EnterViewController.swift
//  BNET_Test
//
//  Created by Denis Velikanov on 06.09.2021.
//

import UIKit

final class EnterViewController: UIViewController {
    
    private let nameField = UITextField()
    private let emailField = UITextField()
    private let okButton = GradientButton(colors: [UIColor.systemBlue.cgColor, UIColor.link.cgColor])

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        constraintUI()
    }
    
    private func setupUI() {
        [nameField, emailField, okButton].forEach { view.addSubview($0) }
        nameField.backgroundColor = .systemGray
        emailField.backgroundColor = .systemGray
        
        nameField.placeholder = "Enter name"
        emailField.placeholder = "Enter email"
        
        [nameField, emailField].forEach { $0.textAlignment = .center }
        [nameField, emailField, okButton].forEach { $0.enableCornerRadius(radius: 15) }

        okButton.setTitle("OK", for: .normal)
        okButton.addTarget(self, action: #selector(okTapped), for: .touchUpInside)
        
    }
    
    private func constraintUI() {
        nameField.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: emailField.safeAreaLayoutGuide.topAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 100, left: 60, bottom: 10, right: 60))
        emailField.anchor(top: nameField.safeAreaLayoutGuide.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 10, left: 60, bottom: 10, right: 60))
        okButton.anchor(top: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 10, left: 60, bottom: 140, right: 60))
        [nameField, emailField].forEach { $0.heightAnchor.constraint(equalToConstant: view.layer.bounds.height / 8).isActive = true }
        
    }

    
    @objc func okTapped() {
        print("ok")
        let listVC = ListViewController()
        navigationController?.pushViewController(listVC, animated: true)
    }

}

