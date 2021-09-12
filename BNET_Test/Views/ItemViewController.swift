//
//  ItemViewController.swift
//  BNET_Test
//
//  Created by Denis Velikanov on 11.09.2021.
//

import UIKit

final class ItemViewController: UIViewController {
    
    let dataFetcher: DataFetcher
    let item: EntriesListDataModel
    
    private let textView = UITextView()
    private let doneButton = UIButton()
    private let cancelButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        setupUI()
        constraintUI()
        createToolBar()
    }
    
    private func setupUI() {
        [textView, doneButton, cancelButton].forEach { view.addSubview($0) }
        
        textView.text = item.body
        
        doneButton.setTitle("Save", for: .normal)
        doneButton.backgroundColor = .systemGreen
        doneButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.backgroundColor = .systemRed
        cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
    }
    
    private func constraintUI() {
        textView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
        doneButton.anchor(top: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: cancelButton.safeAreaLayoutGuide.leadingAnchor)
        cancelButton.anchor(top: nil, leading: doneButton.safeAreaLayoutGuide.trailingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
        doneButton.heightAnchor.constraint(equalTo: cancelButton.heightAnchor).isActive = true
        doneButton.widthAnchor.constraint(equalTo: cancelButton.widthAnchor).isActive = true
    }
    
    @objc func saveTapped() {
        guard let bodyString = textView.text else { print("no text"); return }
        if item.id != "" && item.body != bodyString {
            // change item request here
            navigationController?.popViewController(animated: true)
        }
        
        if item.id == "" {
            dataFetcher.addNewEntryRequest(body: bodyString) { [weak self] response in
                print(response?.status as Any)
                self?.dataFetcher.addEntryGroup.leave()
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @objc func cancelTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func createToolBar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.barStyle = .black
        
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .plain,
                                         target: self,
                                         action: #selector(dismissKeyboard))
        
        toolbar.setItems([doneButton], animated: true)
        toolbar.isUserInteractionEnabled = true
        
        textView.inputAccessoryView = toolbar
        
        toolbar.tintColor = .white
        toolbar.barTintColor = .black
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    init(dataFetcher: DataFetcher, item: EntriesListDataModel) {
        self.dataFetcher = dataFetcher
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
