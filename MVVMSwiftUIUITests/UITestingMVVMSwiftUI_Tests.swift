//
//  UITestingMVVMSwiftUI_Tests.swift
//  MVVMSwiftUIUITests
//
//  Created by Bryan Caro on 10/9/22.
//

import XCTest

class UITestingMVVMSwiftUI_Tests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDownWithError() throws {}
    
    func test_AppView_tapGesture_shouldNavigateToContentView() {
        //  Given
        
        //  When
        let rootView = XCUIApplication().windows.children(matching: .other).element.children(matching: .other).element
        rootView.tap()
        
        let contentView = rootView.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        contentView.tap()
        
        //  Then
        XCTAssertTrue(contentView.exists)
    }
    
    func test_AppView_tapGesture_shouldNavigateToDetailView() {
        //  Given
        navigateToContentView()
        
        //  When
        let openDetailButton = app.buttons["OpenDetailViewButton"]
        openDetailButton.tap()
        
        let detailView = app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        
        //  Then
        XCTAssertTrue(detailView.exists)
    }
    
    func test_AppView_tapGesture_shouldNavigateToRedBackgroundView() {
        //  Given
        navigateToDetailView()
        
        //  When
        let openRedBackgroundButton = app.buttons["OpenRedBackgroundViewButton"]
        openRedBackgroundButton.tap()
        
        let backgroundView = XCUIApplication().windows.children(matching: .other).element.children(matching: .other).element
        
        //  Then
        XCTAssertTrue(backgroundView.exists)
    }
    
    func test_AppView_tapGesture_shouldDisplayLoadingView() {
        //  Given
        navigateToContentView()
        
        //  When
        let successApiCallButton = app.buttons["SuccessAPIButton"]
        successApiCallButton.tap()
        
        let loadingView = app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        
        XCTAssertTrue(loadingView.exists)
        
        let loadingTitle = app.staticTexts["Loading"]
        
        let loadingExists = loadingTitle.waitForExistence(timeout: 5)
        
        //  Then
        XCTAssertTrue(loadingExists)
    }
    
    func test_AppView_tapGesture_shouldDisplayAndHideLoadingView() {
        //  Given
        displayLoadingView()
        
        //  When
        let loadingView = app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        
        XCTAssertTrue(loadingView.exists)
        
        let loadingTitle = app.staticTexts["Loading"]
        
        let loadingExists = loadingTitle.waitForExistence(timeout: 5)
        XCTAssertTrue(loadingExists)
        
        sleep(1)
        //  Then
        XCTAssertFalse(loadingTitle.exists)
    }
    
    func test_AppView_tapGesture_shouldDisplayAlertView() {
        //  Given
        navigateToContentView()
        
        //  When
        let failureApiCallButton = app.buttons["FailureAPIButton"]
        failureApiCallButton.tap()
        
        let loadingView = app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        
        XCTAssertTrue(loadingView.exists)
        
        let loadingTitle = app.staticTexts["Loading"]
        
        let loadingExists = loadingTitle.waitForExistence(timeout: 5)
        XCTAssertTrue(loadingExists)
        
        sleep(1)
        
        XCTAssertFalse(loadingTitle.exists)
        
        //  Then
        let alertExist = app.alerts.firstMatch.waitForExistence(timeout: 5)
        XCTAssertTrue(alertExist)
        
        let alertTitle = app.alerts["Title"].scrollViews.otherElements
        XCTAssertTrue(alertTitle.element.exists)
    }
    
    func test_AppView_tapGesture_shouldDisplayAndDismissAlertView() {
        //  Given
        showAlertView()
        
        //  When
        let alertExist = app.alerts.firstMatch.waitForExistence(timeout: 5)
        XCTAssertTrue(alertExist)
        
        let alertTitle = app.alerts["Title"].scrollViews.otherElements
        XCTAssertTrue(alertTitle.element.exists)
        
        let alertOkButton = alertTitle.buttons["Ok"]
        alertOkButton.tap()
        
        sleep(1)
        
        //  Then
        XCTAssertFalse(alertTitle.firstMatch.exists)
    }
}

//  MARK: - General Functions
extension UITestingMVVMSwiftUI_Tests {
    func navigateToContentView() {
        let rootView = XCUIApplication().windows.children(matching: .other).element.children(matching: .other).element
        rootView.tap()
        
        let contentView = rootView.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        contentView.tap()
    }
    
    func navigateToDetailView() {
        navigateToContentView()
        
        let openDetailButton = app.buttons["OpenDetailViewButton"]
        openDetailButton.tap()
    }
    
    func displayLoadingView() {
        navigateToContentView()
        
        let successApiCallButton = app.buttons["SuccessAPIButton"]
        successApiCallButton.tap()
    }
    
    func showAlertView() {
        navigateToContentView()
        
        let failureApiCallButton = app.buttons["FailureAPIButton"]
        failureApiCallButton.tap()
    }
}
