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
    
    let dataProvider = DataProvider()

    private let urlString = "https://bnet.i-partner.ru/testAPI/"
    private let token = "N0r5HVW-gF-Cwj82tY"
    private var sessionID = "6VuJikGayI9rxWFCBE"
    
    let entriesGroup = DispatchGroup()
    
    func newSessionRequest() {
        //  new_session
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("\(token)", forHTTPHeaderField: "token")
        
        let sessionData = "a=\(APIMethods.new_session)".data(using: .utf8)
        request.httpBody = sessionData
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard error == nil else { print(error!.localizedDescription);
                let alert = UIAlertController(title: "Something is wrong", message: "Check your network!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
                }))
                let vc = ListViewController()
                vc.present(alert, animated: true, completion: nil);
                return }
            guard let data = data else { print("Empty data"); return }
  
            let decoder = JSONDecoder()
            do {
                
                let newSessionID = try decoder.decode(NewSessionModel.self, from: data)
                self?.sessionID = newSessionID.data.session
                
            } catch {
                print("OUCH: \(error)")
            }
            
            if let str = String(data: data, encoding: .utf8) {
                print(str)
            }
        }
        task.resume()
    }
    
    func entriesRequest() {
        // get_entries
        entriesGroup.enter()
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("\(token)", forHTTPHeaderField: "token")
        
        let sessionData = "a=\(APIMethods.get_entries)&session=\(sessionID)".data(using: .utf8)
        request.httpBody = sessionData
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            
            guard error == nil else { print(error!.localizedDescription); return }
            guard let data = data else { print("Empty data"); return }
            
            let decoder = JSONDecoder()
            do {
                
                let entriesData = try decoder.decode(EntriesListModel.self, from: data)
                self?.dataProvider.entries = entriesData
                print(entriesData.data[0][0].id)
                
                self?.entriesGroup.leave()
                print(self?.dataProvider.entries as Any)
            } catch {
                print("OUCH: \(error)")
            }
            if let str = String(data: data, encoding: .utf8) {
                print(str)
            }
        }
        task.resume()
    }
    
    func addNewEntryRequest(body: String) {
        // add_entry
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("\(token)", forHTTPHeaderField: "token")
        
        let sessionData = "a=\(APIMethods.add_entry)&session=\(sessionID)&body=\(body)".data(using: .utf8)
        request.httpBody = sessionData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else { print(error!.localizedDescription); return }
            guard let data = data else { print("Empty data"); return }
            
            if let str = String(data: data, encoding: .utf8) {
                print(str)
            }
        }
        task.resume()
    }
}


