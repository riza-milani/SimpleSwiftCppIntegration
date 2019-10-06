//
//  ServiceCall.swift
//  SimpleSwiftCppCode
//
//  Created by riza milani on 5/31/1398 AP.
//  Copyright © 1398 reza milani. All rights reserved.
//

import Foundation

protocol ServiceCall {
    func fetchNumbers(completion: @escaping ((Result<NumberData, Error>) -> Void))
}

class ServiceCallApi: ServiceCall {
    func fetchNumbers(completion: @escaping ((Result<NumberData, Error>) -> Void)) {
        DispatchQueue.global(qos: .background).async {
            let endpoint: String = "URL/numbers.json"
            guard let url = URL(string: endpoint) else {
                completion(.failure(NSError(domain: "Can not create url address.", code: 0, userInfo: nil)))
                return
            }
            let urlRequest = URLRequest(url: url)
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            
            let task = session.dataTask(with: urlRequest) { (data, response, error) in
                guard error == nil else {
                    completion(.failure(error!))
                    return
                }
                guard let dataResponse = data else {
                    completion(.failure(NSError(domain: "There is no data response.", code: 0, userInfo: nil)))
                    return
                }
                guard let numberData = try? JSONDecoder().decode(NumberData.self, from: dataResponse) else {
                    completion(.failure(NSError(domain: "Can not decode the data.", code: 0, userInfo: nil)))
                    return
                }
                completion(.success(numberData))
            }
            task.resume()
        }
    }
}

class ServiceCallLocal: ServiceCall {
    func fetchNumbers(completion: @escaping ((Result<NumberData, Error>) -> Void)) {
        let filePath = Bundle.main.path(forResource: "numbers", ofType: "json")
        DispatchQueue.global(qos: .userInitiated).async {
            guard
                let path = filePath,
                let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
                let numberData = try? JSONDecoder().decode(NumberData.self, from: data)
                else {
                    completion(.failure(NSError(domain: "Can not decode the data.", code: 0, userInfo: nil)))
                    return
            }
            completion(.success(numberData))
        }
    }
}
