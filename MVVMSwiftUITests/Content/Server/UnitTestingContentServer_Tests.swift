//
//  UnitTestingContentServer_Tests.swift
//  MVVMSwiftUITests
//
//  Created by Bryan Caro on 8/9/22.
//

import XCTest
@testable import MVVMSwiftUI
import Combine

class UnitTestingContentServer_Tests: XCTestCase {
    
    var server: ContentServer?
    private var cancellableGetLondonWeather: Cancellable?
    private var cancellableGetLondonWeatherErrorMsg: Cancellable?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        server = ContentServer()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        server = nil
    }
    
    func test_ContentServer_getLondonWeather_shouldNotBeNil() {
        //  Given
        guard let server = server else {
            return XCTFail()
        }
        
        let manager = server.manager
        
        //  When
        var londonWeatherResponse: LocationWeatherResponse?
        let expectation = XCTestExpectation()
        
        cancellableGetLondonWeather = manager.getLondonWeather()
            .sink { result in
                switch result {
                case .finished:
                    expectation.fulfill()
                case .failure:
                    XCTFail()
                }
            } receiveValue: { response in
                londonWeatherResponse = response
            }
        
        //  Then
        wait(for: [expectation], timeout: 5)
        XCTAssertNotNil(londonWeatherResponse)
    }
    
    func test_ContentServer_getLondonWeatherErrorMsg_doesFail() {
        //  Given
        guard let server = server else {
            return XCTFail()
        }
        
        let manager = server.manager
        let errorType: ServerManagerError = .clientError("Nothing to geocode")
        
        //  When
        var londonWeatherResponse: LocationWeatherResponse?
        let expectation  = XCTestExpectation(description: "Does trow an error")
        let expectation2 = XCTestExpectation(description: "Does trow ServerError")
        
        cancellableGetLondonWeatherErrorMsg = manager.getLondonWeatherErrorMsg()
            .sink { result in
                switch result {
                case .finished:
                    XCTFail()
                case .failure(let error):
                    expectation.fulfill()
                    
                    let appError = error as? ServerManagerError
                    XCTAssertEqual(appError, errorType)
                    
                    if appError == errorType {
                        expectation2.fulfill()
                    }
                }
            } receiveValue: { response in
                londonWeatherResponse = response
            }
        
        //  Then
        wait(for: [expectation, expectation2], timeout: 2)
        XCTAssertNil(londonWeatherResponse)
    }
    
    func test_ContentServer_getLondonWeatherErrorMsg_doesFailWithDiffentErrorType() {
        //  Given
        guard let server = server else {
            return XCTFail()
        }
        
        let manager = server.manager
        let errorType: ServerManagerError = .serverError("Nothing to geocode")
        
        //  When
        var londonWeatherResponse: LocationWeatherResponse?
        let expectation  = XCTestExpectation(description: "Does trow an error")
        let expectation2 = XCTestExpectation(description: "Does trow ServerError")
        
        cancellableGetLondonWeatherErrorMsg = manager.getLondonWeatherErrorMsg()
            .sink { result in
                switch result {
                case .finished:
                    XCTFail()
                case .failure(let error):
                    expectation.fulfill()
                    
                    let appError = error as? ServerManagerError
                    XCTAssertNotEqual(appError, errorType)
                    
                    if appError != errorType {
                        expectation2.fulfill()
                    }
                }
            } receiveValue: { response in
                londonWeatherResponse = response
            }
        
        //  Then
        wait(for: [expectation, expectation2], timeout: 2)
        XCTAssertNil(londonWeatherResponse)
    }
}
