//
//  ServiceCallMock.swift
//  SimpleSwiftCppCodeTests
//
//  Created by riza milani on 5/31/1398 AP.
//  Copyright © 1398 reza milani. All rights reserved.
//

import Foundation
@testable import SimpleSwiftCppCode

class ServiceCallMock: ServiceCall {
    
    var generateError = false
    
    init(generateError: Bool = false) {
        self.generateError = generateError
    }
    
    func fetchNumbers(completion: @escaping ((Result<NumberData, Error>) -> Void)) {
        DispatchQueue.global(qos: .userInitiated).async {
            let numberData: NumberData = try! JSONDecoder().decode(NumberData.self, from: JSONDecoder.readMockJson(fileName: "numbersTest"))
            if self.generateError {
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "Custom generated error.", code: 0, userInfo: nil)))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.success(numberData))
                }
            }
        }
    }
}

extension JSONDecoder {
    class func readMockJson(fileName: String) -> Data {
        let testBundle = Bundle(identifier: "com.rmt.test.SimpleSwiftCppCodeTests")!
        if let path = testBundle.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {
                return Data()
            }
        }
        return Data()
    }
}
