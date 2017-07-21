//
//  TestDPUITests.swift
//  TestDPUITests
//
//  Created by Dima Gubatenko on 18.07.17.
//  Copyright © 2017 Dima Gubatenko. All rights reserved.
//

import XCTest

class TestDPUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertTrue(true)
    }

    func testCurrenciesSearch() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        let searchField = tablesQuery.children(matching: .searchField).element
        searchField.tap()
        searchField.typeText("G")
        app.keys["b"].tap()
        searchField.typeText("b")
        tablesQuery.buttons["Cancel"].tap()
    }

    func testCurrenciesRateScreen() {
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["DKK"].tap()
        let gbpStaticText = app.staticTexts["GBP"]
        gbpStaticText.tap()
        gbpStaticText.swipeRight()
        app.staticTexts["DKK"].swipeRight()
    }
}
