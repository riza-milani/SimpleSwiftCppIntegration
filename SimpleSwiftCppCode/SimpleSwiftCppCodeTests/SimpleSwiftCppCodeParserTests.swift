//
//  SimpleSwiftCppCodeTests.swift
//  SimpleSwiftCppCodeTests
//
//  Created by riza milani on 5/31/1398 AP.
//  Copyright © 1398 reza milani. All rights reserved.
//

import XCTest
@testable import SimpleSwiftCppCode

class SimpleSwiftCppCodeParserTests: XCTestCase {

    var parser: NumberParser?
    let numbers: [UInt8] = [4, 150, 12, 21, 136, 16, 3]

    override func setUp() {
        parser = NumberParser()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNumberParserInit() {
        XCTAssertNotNil(parser)
    }

    func testIsChecked() {
        let resultCheckMark: [Bool] = [false, true, false, false, true, false, false]

        for (index, number) in numbers.enumerated() {
            XCTAssertEqual(resultCheckMark[index], parser?.isChecked(number))
        }
    }

    func testGetSection() {
        // Added one to all results. as mentioned in the exam question
        let resultSection: [UInt8] = [1, 3, 1, 2, 1, 1, 4]

        for (index, number) in numbers.enumerated() {
            XCTAssertEqual(resultSection[index], parser?.getSection(number))
        }
    }

    func testGetItem() {
        // Added one to all results. as mentioned in the exam question
        let resultItem: [UInt8] = [2, 6, 4, 6, 3, 5, 1]

        for (index, number) in numbers.enumerated() {
            XCTAssertEqual(resultItem[index], parser?.getItem(number))
        }
    }



}
