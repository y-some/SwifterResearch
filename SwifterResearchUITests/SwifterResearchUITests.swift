//
//  SwifterResearchUITests.swift
//  SwifterResearchUITests
//
//  Created by Yasuyuki Someya on 2018/11/18.
//  Copyright © 2018年 Yasuyuki Someya. All rights reserved.
//

import XCTest

class SwifterResearchUITests: XCTestCase {
    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        app.launchEnvironment = ["STUB": "http://localhost:9080/"]
        app.launch()
    }

    override func tearDown() {
    }

    func testExample() {
        XCTContext.runActivity(named: "トップページがWebViewで表示されること") { (activity) in
            let webViewTitle = app.webViews.staticTexts["スタブのHTMLです。"]
            XCTAssertEqual(waitAppearance(for: webViewTitle), .completed)
        }
        XCTContext.runActivity(named: "URLスキームをtapしたらalertが表示されること") { (activity) in
            app.webViews.links["URLスキーム"].tap()
            let alert = app.alerts.staticTexts["URLスキームのリンクがtapされました。"]
            XCTAssertEqual(waitAppearance(for: alert), .completed)
        }
    }
}

extension XCTestCase {
    /// elementの出現を待つ
    func waitAppearance(for element: Any) -> XCTWaiter.Result {
        let exp = expectation(for: NSPredicate(format: "exists == true"), evaluatedWith: element, handler: nil)
        let result = XCTWaiter.wait(for: [exp], timeout: 3.0)
        return result
    }
}
