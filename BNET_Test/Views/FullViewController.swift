//
//  FullViewController.swift
//  BNET_Test
//
//  Created by Denis Velikanov on 06.09.2021.
//

import UIKit

final class FullViewController: UIViewController {
    
    private let bodyLabel = UILabel()
    private let dateLabel = UILabel()
    private let modLabel = UILabel()
    
    let item: EntriesListDataModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        constraintUI()
    }
    
    private func setupUI() {
        [dateLabel, modLabel, bodyLabel].forEach { view.addSubview($0) }
        [dateLabel, modLabel, bodyLabel].forEach { $0.enableCornerRadius(radius: 15) }
        [bodyLabel, dateLabel, modLabel].forEach { $0.backgroundColor = .lightGray }
        [dateLabel, modLabel].forEach { $0.adjustsFontSizeToFitWidth = true }
        bodyLabel.textAlignment = .center
        
        dateLabel.text = "date creation: \(item.da)"
        modLabel.text = "date modified: \(item.dm)"
        bodyLabel.text = item.body
    }
    
    private func constraintUI() {
        dateLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: bodyLabel.safeAreaLayoutGuide.topAnchor, trailing: modLabel.safeAreaLayoutGuide.leadingAnchor)
        modLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: dateLabel.safeAreaLayoutGuide.trailingAnchor, bottom: bodyLabel.safeAreaLayoutGuide.topAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
        bodyLabel.anchor(top: dateLabel.safeAreaLayoutGuide.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
    }
    

    init(item: EntriesListDataModel) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
