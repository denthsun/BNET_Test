//
//  AddViewController.swift
//  BNET_Test
//
//  Created by Denis Velikanov on 06.09.2021.
//

import UIKit

final class AddViewController: UIViewController {
    
    private let textFiled = UITextField()
    let dataFetcher: DataFetcher
    let doneButton = GradientButton(colors: [UIColor.systemGreen.cgColor])
    let cancelButton = GradientButton(colors: [UIColor.systemRed.cgColor])

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        setupUI()
        constraintUI()
    }
    
    private func setupUI() {
        [textFiled, doneButton, cancelButton].forEach { view.addSubview($0) }
        textFiled.placeholder = "Enter your stuff"
        
        doneButton.setTitle("Done", for: .normal)
        doneButton.backgroundColor = .systemGreen
        doneButton.addTarget(self, action: #selector(doneTapped), for: .touchUpInside)
        
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.backgroundColor = .systemRed
        cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
    }
    
    private func constraintUI() {
        textFiled.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: doneButton.safeAreaLayoutGuide.topAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 10, right: 10))
        doneButton.anchor(top: textFiled.safeAreaLayoutGuide.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: cancelButton.safeAreaLayoutGuide.leadingAnchor, padding: .init(top: 10, left: 10, bottom: 10, right: 10))
        cancelButton.anchor(top: textFiled.safeAreaLayoutGuide.bottomAnchor, leading: doneButton.safeAreaLayoutGuide.trailingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 10, right: 10))
        doneButton.widthAnchor.constraint(equalTo: cancelButton.widthAnchor).isActive = true
    }
    
    @objc func doneTapped() {
        
        guard let bodyString = textFiled.text else { print("no text"); return }
        
        dataFetcher.addNewEntryRequest(body: bodyString)
        
        let listVC = ListViewController()
        navigationController?.pushViewController(listVC, animated: true)
    }
    
    @objc func cancelTapped() {
        navigationController?.popViewController(animated: true)
    }
    

    init(dataFetcher: DataFetcher) {
        self.dataFetcher = dataFetcher
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
