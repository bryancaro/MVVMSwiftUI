//
//  UnitTestingContentViewModel_Tests.swift
//  MVVMSwiftUITests
//
//  Created by Bryan Caro on 8/9/22.
//

import XCTest
@testable import MVVMSwiftUI
import Combine

// Naming Structure : test_[struct or class]_[variable or function]_[expected result]
// Testing Structure: Given, When, Then

class UnitTestingContentViewModel_Tests: XCTestCase {
    var viewModel: ContentView.ViewModel?
    var cancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = ContentView.ViewModel()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }
    
    func test_ContentViewModel_isLoading_shouldBeTrue() {
        //  Given
        //  Loading is true by default
        
        //  When
        guard let vm = viewModel else {
            return XCTFail()
        }
        
        //  Then
        XCTAssertTrue(vm.isLoading)
    }
    
    func test_ContentViewModel_isLoading_shouldBeFalse() {
        //  Given
        let isLoading: Bool = false
        
        //  When
        let vm = ContentView.ViewModel(isLoading)
        
        //  Then
        XCTAssertFalse(vm.isLoading)
    }
    
    func test_ContentViewModel_isLoading_shouldBeInjectedValue() {
        //  Given
        let isLoading: Bool = Bool.random()
        
        //  When
        let vm = ContentView.ViewModel(isLoading)
        
        //  Then
        XCTAssertEqual(vm.isLoading, isLoading)
    }
    
    func test_ContentViewModel_isLoading_shouldBeInjectedValue_stress() {
        for _ in 0..<10 {
            //  Given
            let isLoading: Bool = Bool.random()
            
            //  When
            let vm = ContentView.ViewModel(isLoading)
            
            //  Then
            XCTAssertEqual(vm.isLoading, isLoading)
        }
    }
    
    func test_ContentViewModel_londonWeather_shouldBeNill() {
        //  Given
        
        //  When
        guard let vm = viewModel else {
            return XCTFail()
        }
        
        //  Then
        XCTAssertNil(vm.londonWeather)
    }
    
    func test_ContentViewModel_londonWeather_shouldBeSetLondonWeather() {
        //  Given
        guard let vm = viewModel else {
            return XCTFail()
        }
        
        //  When
        let londonWeather = LocationWeatherModel(LocationWeatherResponse.mockUp)
        vm.configureLondonWeather(londonWeather)
        
        //  Then
        XCTAssertEqual(vm.londonWeather, londonWeather)
        XCTAssertNotNil(vm.londonWeather)
    }
    
    func test_ContentViewModel_londonWeather_shouldIdNotBeNil() {
        //  Given
        guard let vm = viewModel else {
            return XCTFail()
        }
        
        //  When
        let londonWeather = LocationWeatherModel(LocationWeatherResponse.mockUp)
        vm.configureLondonWeather(londonWeather)
        
        //  Then
        XCTAssertEqual(vm.londonWeather, londonWeather)
        XCTAssertNotNil(vm.londonWeather?.id)
    }
    
    func test_ContentViewModel_getLondonWeatherAction_shouldIdNotBeNil() {
        //  Given
        guard let vm = viewModel else {
            return XCTFail()
        }
        
        //  When
        let expectation = XCTestExpectation(description: "Should return data after api call response.")
        vm.$londonWeather
            .dropFirst()
            .sink { model in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        vm.getLondonWeatherAction()
        
        //  Then
        wait(for: [expectation], timeout: 3)
        XCTAssertNotNil(vm.londonWeather)
    }
}
