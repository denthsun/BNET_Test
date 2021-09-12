//
//  APIResponseModel.swift
//  BNET_Test
//
//  Created by Denis Velikanov on 12.09.2021.
//

import Foundation

struct APIResponseModel: Decodable {
    var status: Int
    var data: APIResponseDataModel
}

struct APIResponseDataModel: Decodable {
    var session: String?
    var id: String?
}
