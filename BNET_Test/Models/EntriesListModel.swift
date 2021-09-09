//
//  EntriesListModel.swift
//  BNET_Test
//
//  Created by Denis Velikanov on 08.09.2021.
//

import Foundation

struct EntriesListModel: Decodable {
    var status: Int
    var data: [[EntriesListDataModel]]
}

struct EntriesListDataModel: Decodable {
    var id: String
    var body: String
    var da: String
    var dm: String
}


