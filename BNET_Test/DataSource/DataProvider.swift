//
//  DataProvider.swift
//  BNET_Test
//
//  Created by Denis Velikanov on 06.09.2021.
//

import Foundation
import RxSwift
import RxCocoa

class DataProvider {

    var items = PublishSubject<[EntriesListDataModel]>()
    
    var entries: EntriesListModel = EntriesListModel(status: 0, data: [[EntriesListDataModel(id: "1", body: "2", da: "1", dm: "1")]])
    
    func fetchItems() {
        items.onNext(entries.data[0])
        items.onCompleted()
    }
    
}
