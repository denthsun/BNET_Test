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
    private let addButton = UIButton()
    private let dataFetcher = DataFetcher()
    private var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTVCell()
        setupUI()
        constraintUI()
        // newSessionRequests()
        entriesRequest()
        bindData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
// по идее при поп переходе с ItemVC тут должны вызываться функции нового запроса списка записей и обновляться tableView, но этого не происходит. потратил много времени на это, но в итоге не понял, что не срабатывает. думаю дело в том, что нужно получше изучить RX
        
        dataFetcher.getNewEntriesRequest { entries in
            guard let newLIst = entries else { return }
            self.dataFetcher.dataProvider.entries = newLIst
            print(newLIst.data[0][1].body as Any)
        }
    }
    
    private func setupUI() {
        [tableView, addButton].forEach { view.addSubview($0) }
        
        addButton.setTitle("+", for: .normal)
        addButton.backgroundColor = .black
        addButton.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        
        title = "Enties Collection"
    }
    
    private func constraintUI() {
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
        addButton.anchor(top: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
    }
    
    private func registerTVCell() {
        tableView.register(ItemCell.self, forCellReuseIdentifier: ItemCell.identifier)
    }
    
    private func bindData() {
        dataFetcher.entriesGroup.notify(queue: DispatchQueue.global()) {
            DispatchQueue.main.async { [weak self] in
                self?.bindTableView()
            }
        }
    }
    
    private func newSessionRequests() {
        dataFetcher.newSessionRequest { [weak self] newSessionID in
            guard let newID = newSessionID else { return }
            self?.dataFetcher.sessionID = newID.data.session ?? ""
            self?.dataFetcher.newSessionGroup.leave()
        }
    }
    
    private func entriesRequest() {
        dataFetcher.getEntriesRequest { [weak self] entries in
            guard let newList = entries else { print("no entries"); return }
            self?.dataFetcher.dataProvider.entries = newList
            self?.dataFetcher.entriesGroup.leave()
        }
    }
    
    @objc func addTapped() {
        let addVC = ItemViewController(dataFetcher: dataFetcher, item: EntriesListDataModel(id: "", body: "", da: "", dm: ""))
        navigationController?.pushViewController(addVC, animated: true)
    }
    
    func bindTableView() {
        dataFetcher.dataProvider.items.bind(to: tableView.rx.items(cellIdentifier: ItemCell.identifier, cellType: ItemCell.self)) { row, item, cell in
            
            if item.da < item.dm {
                cell.dateLabel.text = item.dm
            } else {
                cell.dateLabel.text = item.da
            }
            
            cell.bodyLabel.text = item.body.maxLength(length: 200)
            
        }.disposed(by: bag)
        
        tableView.rx.modelSelected(EntriesListDataModel.self).bind { [weak self] item in
            let fullVC = ItemViewController(dataFetcher: (self?.dataFetcher)!, item: item)
            self?.navigationController?.pushViewController(fullVC, animated: true)
        }.disposed(by: bag)
        
        dataFetcher.dataProvider.fetchItems()
    }
}
