//
//  TestDPTests.swift
//  TestDPTests
//
//  Created by Dima Gubatenko on 18.07.17.
//  Copyright © 2017 Dima Gubatenko. All rights reserved.
//

import XCTest
@testable import TestDP

class TestDPTests: XCTestCase {

    var server: Server!
    
    override func setUp() {
        super.setUp()
        server = Server()
    }
    
    override func tearDown() {
        server = nil
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertTrue(true)
    }

    func testGetRates() {
        let wait = expectation(description: "server get rates")
        var models = [CurrencyModel]()
        server.getRates { result in
            switch result {
                case .error(let text): XCTAssertTrue(false, text)
                case .success(let _models):
                    models = _models
                    wait.fulfill()
            }
        }
        waitForExpectations(timeout: 20, handler: nil)
        XCTAssertFalse(models.isEmpty)
    }

    func testGetRateInfo() {
        var models = [CurrencyInfoModel]()
        let rate = getRate()
        let wait = expectation(description: "server get rate info")
        server.getRateInfo(rate: rate) { result in
            switch result {
            case .error(let text): XCTAssertTrue(false, text)
            case .success(let _models):
                models = _models
                wait.fulfill()
            }
        }
        waitForExpectations(timeout: 20, handler: nil)
        XCTAssertFalse(models.isEmpty)
    }

    private func getRate() -> CurrencyModel {
        let wait = expectation(description: "server get rates")
        var models = [CurrencyModel]()
        server.getRates { result in
            switch result {
            case .error(let text): XCTAssertTrue(false, text)
            case .success(let _models):
                models = _models
                wait.fulfill()
            }
        }
        waitForExpectations(timeout: 20, handler: nil)
        XCTAssertFalse(models.isEmpty)
        return models.first!
    }
}
