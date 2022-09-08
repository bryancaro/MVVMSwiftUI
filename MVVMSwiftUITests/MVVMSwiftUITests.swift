//
//  MVVMSwiftUITests.swift
//  MVVMSwiftUITests
//
//  Created by Bryan Caro on 8/9/22.
//

import XCTest
@testable import MVVMSwiftUI

/*
    Naming Structure: test_UnitOfWork_StateUnderTest_ExpectedBehavior
 
    Testing Structure: Given, When, Then
 */

class MVVMSwiftUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_ContentViewModel_isLoading_shouldBeTrue() {
        //  Given
        //  Loading is true by default
        
        //  When
        let vm = ContentView.ViewModel()
        
        //  Then
        XCTAssertTrue(vm.isLoading)
    }
    
    func test_ContentViewModel_isLoading_shouldBeFalse() {
        //  Given
        //  Loading is true by default
        
        //  When
        let vm = ContentView.ViewModel()
        
        //  Then
        XCTAssertFalse(vm.isLoading)
    }
}
