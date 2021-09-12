//
//  NetworkDataFetcher.swift
//  GradientApp
//
//  Created by Denis Velikanov on 16.02.2021.
//

import Foundation

protocol DataFetcherProtocol {
    func fetchGETGenericData<T: Decodable>(urlString: String, response: @escaping (T?) -> Void)
    func fetchPOSTGenericData<T: Decodable>(urlString: String, parameters: String, response: @escaping (T?) -> Void)
}

class NetworkDataFetcher: DataFetcherProtocol {
    
    var networking: Networking
    
    func fetchGETGenericData<T: Decodable>(urlString: String, response: @escaping (T?) -> Void) {
        networking.apiGETRequest(urlString: urlString) { (data, error) in
            if let error = error {
                print("Error received requesting data, \(error.localizedDescription)")
                response(nil)
            }
            let decoded = self.decodeJSON(type: T.self, from: data)
            return response(decoded)
        }
    }
    
    func fetchPOSTGenericData<T: Decodable>(urlString: String, parameters: String, response: @escaping (T?) -> Void) {
        networking.apiPOSTRequest(urlString: urlString, parameters: parameters) { (data, error) in
            if let error = error {
                print("Error received requesting data, \(error.localizedDescription)")
            }
            let decoded = self.decodeJSON(type: T.self, from: data)
            return response(decoded)
        }
    }
    
    func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Failed to decode, \(jsonError.localizedDescription)")
            return nil
        }
    }
    
    init(networking: Networking = NetworkService()) {
        self.networking = networking
    }
    
}
