//
//  ListViewController.swift
//  BNET_Test
//
//  Created by Denis Velikanov on 06.09.2021.
//

import UIKit
import RxSwift
import RxCocoa

final class ListViewController: UIViewController {
    
    private let tableView = UITableView()
    private let addButton = GradientButton(colors: [UIColor.systemBlue.cgColor])
    
    private let dataFetcher = DataFetcher()
    private var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTVCell()
        setupUI()
        constraintUI()
        //     presenter.dataFetcher.newSessionRequest()
        dataFetcher.entriesRequest()
        updateUI()
    }
    
    private func updateUI() {
        dataFetcher.entriesGroup.notify(queue: DispatchQueue.global()) {
            DispatchQueue.main.async { [weak self] in
                self?.bindTableView()
            }
        }
    }
    
    private func setupUI() {
        [tableView, addButton].forEach { view.addSubview($0) }
        
        addButton.enableCornerRadius(radius: 45)
        addButton.setTitle("+", for: .normal)
        addButton.backgroundColor = .black
        addButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
    }
    
    private func constraintUI() {
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
        addButton.anchor(top: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 130, bottom: 50, right: 130))
    }
    
    private func registerTVCell() {
        tableView.register(TableViewCell.nib(), forCellReuseIdentifier: TableViewCell.identifier)
    }
    
    @objc func addTapped() {
        let addVC = AddViewController(dataFetcher: dataFetcher)
        navigationController?.pushViewController(addVC, animated: true)
    }
    
    func bindTableView() {
        
        dataFetcher.dataProvider.items.bind(to: tableView.rx.items(cellIdentifier: TableViewCell.identifier, cellType: TableViewCell.self)) { row, item, cell in
            
            if item.da < item.dm {
                cell.dateLabel.text = item.dm
            } else {
                cell.dateLabel.text = item.da
            }
            
            cell.bodyLabel.text = item.body
            
        }.disposed(by: bag)
        
        tableView.rx.modelSelected(EntriesListDataModel.self).bind { [weak self] item in
            let fullVC = FullViewController(item: item)
            self?.navigationController?.pushViewController(fullVC, animated: true)
        }.disposed(by: bag)
        
        dataFetcher.dataProvider.fetchItems()
    }
}
