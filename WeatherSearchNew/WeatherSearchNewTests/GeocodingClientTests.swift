//
//  GeocodingClientTests.swift
//  WeatherSearchNewTests
//
//  Created by Alessandro Teixeira Lima on 13/02/24.
//

import XCTest

@testable import WeatherSearchNew

class GeocodingClientTests: XCTestCase {

    private var resultLocation: Location?
    private var receivedError: Error?
    
    func testCoordinateByCity_Success() {
        // Given
        let expectedLocation = Location(name: "City Name",
                                        lat: 123.456 ,
                                        lon: 123.456 ,
                                        country: "Country Name" ,
                                        state: "State Name")

        let mockData = try! JSONEncoder().encode([expectedLocation])
        let mockResponse = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        let mockSession = MockURLSession(dataResult: (mockData, mockResponse), errorResult: nil)
        let geocodingClient = GeocodingClient(session: mockSession)

        // When
        let expectation = XCTestExpectation(description: "Fetch coordinates")
        
        Task {
            do {
                resultLocation = try await geocodingClient.coordinateByCity("someCity")
                expectation.fulfill()
            } catch {
                XCTFail("Unexpected error: \(error)")
            }
        }
        wait(for: [expectation], timeout: 5)

        // Then
        XCTAssertEqual(resultLocation, expectedLocation)
    }

    func testCoordinateByCity_NetworkError() {
        // Given
        let mockSession = MockURLSession(dataResult: nil, errorResult: NetworkError.invalidResponse)
        let geocodingClient = GeocodingClient(session: mockSession)

        // When
        let expectation = XCTestExpectation(description: "Fetch coordinates")
       
        Task {
            do {
                _ = try await geocodingClient.coordinateByCity("SomeCity")
                XCTFail("Expected error to be thrown")
            } catch {
                receivedError = error
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 5)

        // Then
        XCTAssertNotNil(receivedError)
        XCTAssertTrue(receivedError is NetworkError)
    }
}
