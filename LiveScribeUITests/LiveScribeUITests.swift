//
//  LiveScribeUITests.swift
//  LiveScribeUITests
//
//  Created by Christian Skorobogatow on 24/2/25.
//

import XCTest

@MainActor
final class LiveScribeUITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    
    func testInputExists() {
        let expectedTextViews = 1
        let actualTextViews = app.textViews.count
        
        XCTAssertEqual(
            actualTextViews,
            expectedTextViews,
            "TextEditor count mismatch: Expected \(expectedTextViews), found \(actualTextViews)"
        )
    }
    
    func testOutputExists() {
        let webViewExists = app.webViews.firstMatch.waitForExistence(timeout: 1)
        XCTAssertTrue(webViewExists, "There should be 1 WKWebView for the user to see their rendered output")
    }
    
    func testOutputMatchesInput() {
        _ = app.webViews.firstMatch.waitForExistence(timeout: 1)
        let targetText =  UUID().uuidString
        app.textViews.firstMatch.tap()
        app.typeText(targetText)
        XCTAssertTrue(app.webViews.firstMatch.staticTexts[targetText].exists, "Typing into the text editor should create matching output")
    }
    
    func testSplitterExists() {
        XCTAssertEqual(app.splitters.count, 1 , "There should be a splitter view to divide the text editor and output")
    }
    
    func testLinksWork() {
        _ = app.webViews.firstMatch.waitForExistence(timeout: 1)
        _ = app.textViews.firstMatch.waitForExistence(timeout: 1)
        app.textViews.firstMatch.tap()
        app.typeText("[Learn Swift](https://www.hackingwithswift.com)")
        XCTAssertEqual(app.links.count, 1, "Creating a link should make it tappable")
    }

}
