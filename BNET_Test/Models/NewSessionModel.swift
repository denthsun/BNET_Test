//
//  NewSessionModel.swift
//  BNET_Test
//
//  Created by Denis Velikanov on 08.09.2021.
//

import Foundation

struct APIResponseModel: Decodable {
    var status: Int
    var data: DataSessionModel
}

struct DataSessionModel: Decodable {
    var session: String?
    var id: String?
}
