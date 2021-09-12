//
//  DataFetcher.swift
//  BNET_Test
//
//  Created by Denis Velikanov on 08.09.2021.
//

import Foundation
import UIKit

enum APIMethods {
    case new_session
    case get_entries
    case add_entry
}

class DataFetcher {
    
    private let apiUrlString = "https://bnet.i-partner.ru/testAPI/"
    private let token = "N0r5HVW-gF-Cwj82tY"
    var sessionID = "6VuJikGayI9rxWFCBE"
    
    let dataProvider = DataProvider()
    var networkDataFetcher: DataFetcherProtocol
    let entriesGroup = DispatchGroup()
    let newSessionGroup = DispatchGroup()
    let addEntryGroup = DispatchGroup()
    
    func newSessionRequest(completion: @escaping (APIResponseModel?) -> Void) {
        newSessionGroup.enter()
        networkDataFetcher.fetchPOSTGenericData(urlString: self.apiUrlString, parameters: "a=\(APIMethods.new_session)", response: completion)
    }
    
    func getEntriesRequest(completion: @escaping (EntriesListModel?) -> Void) {
        entriesGroup.enter()
        networkDataFetcher.fetchPOSTGenericData(urlString: self.apiUrlString, parameters: "a=\(APIMethods.get_entries)&session=\(sessionID)", response: completion)
    }
    
    func addNewEntryRequest(body: String, completion: @escaping (APIResponseModel?) -> Void ) {
        addEntryGroup.enter()
        networkDataFetcher.fetchPOSTGenericData(urlString: self.apiUrlString, parameters: "a=\(APIMethods.add_entry)&session=\(sessionID)&body=\(body)", response: completion)
    }
    
    // костыль похоже, но в данной ситуации проще сделать новый запрос, чем менять всю логику getEntriesRequest
    // но это все равно не сработало(
    func getNewEntriesRequest(completion: @escaping (EntriesListModel?) -> Void) {
        networkDataFetcher.fetchPOSTGenericData(urlString: self.apiUrlString, parameters: "a=\(APIMethods.get_entries)&session=\(sessionID)", response: completion)
    }
    
    init(networkDataFetcher: DataFetcherProtocol = NetworkDataFetcher()) {
        self.networkDataFetcher = networkDataFetcher
    }
}



