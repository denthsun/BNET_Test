//
//  NetworkService.swift
//  GradientApp
//
//  Created by Denis Velikanov on 16.02.2021.
//

import Foundation

protocol Networking {
    func apiGETRequest(urlString: String, completion: @escaping (Data?, Error?) -> Void)
    func apiPOSTRequest(urlString: String, parameters: String, completion: @escaping (Data?, Error?) -> Void)
}

class NetworkService: Networking {
    
    private let token = "N0r5HVW-gF-Cwj82tY"
    
    func apiGETRequest(urlString: String, completion: @escaping (Data?, Error?) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("\(token)", forHTTPHeaderField: "token")
        
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    func apiPOSTRequest(urlString: String, parameters: String, completion: @escaping (Data?, Error?) -> Void) {

        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("\(token)", forHTTPHeaderField: "token")
        request.httpBody = parameters.data(using: .utf8)

        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}
