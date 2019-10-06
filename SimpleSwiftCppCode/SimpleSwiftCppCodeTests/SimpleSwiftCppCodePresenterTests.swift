//
//  SimpleSwiftCppCodePresenterTests.swift
//  SimpleSwiftCppCodeTests
//
//  Created by riza milani on 5/31/1398 AP.
//  Copyright © 1398 reza milani. All rights reserved.
//

import XCTest
@testable import SimpleSwiftCppCode



class SimpleSwiftCppCodePresenterTests: XCTestCase {
    
    var expectation = XCTestExpectation(description: "Test Fetching data")
    var tableViewData: [TableViewData] = []
    var presenter: PresneterProtocol?
    var errorMessage: String = ""

    override func setUp() {
        presenter = Presenter()
        presenter?.delegate = self
        presenter?.serviceCall = ServiceCallMock()
        tableViewData = []
        errorMessage = ""
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchNumbers() {
        let valueCounts = [4,1,1,1]
        let sections: [UInt8] = [1,2,3,4]
        let vaules:[[(UInt8,Bool)]] = [
            [(2,false), (3,true), (4,false), (5,false)],
            [(6,false)],
            [(6,true)],
            [(1,false)],
        ]

        presenter?.fetchNumbers { [weak self] data in
            self?.tableViewData = data
            self?.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 60.0)
        XCTAssertEqual(tableViewData.count, 4)
        for (index,item) in tableViewData.enumerated() {
            XCTAssertEqual(item.value.count, valueCounts[index])
            XCTAssertEqual(item.value.count, valueCounts[index])
            XCTAssertEqual(item.key, sections[index])
            for (itemIndex, itemValue) in item.value.enumerated() {
                XCTAssertEqual(itemValue.0, vaules[index][itemIndex].0)
                XCTAssertEqual(itemValue.1, vaules[index][itemIndex].1)
            }
        }
    }

    func testDelegateShowErrorMessage() {
        let message = "test error message"
        presenter?.delegate?.showErrorMessage(message: message)
        XCTAssertEqual(errorMessage, message)
    }

}

//MARK: ViewControllerProtocol Mock
extension SimpleSwiftCppCodePresenterTests: ViewControllerProtocol {
    func showErrorMessage(message: String) {
        errorMessage = message
    }
}
