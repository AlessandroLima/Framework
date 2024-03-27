//
//  WeatherClientTests.swift
//  WeatherSearchNewTests
//
//  Created by Alessandro Teixeira Lima on 16/02/24.
//

import XCTest

final class WeatherClientTests: XCTestCase {
    
    private var resultWeather: Weather?
    private var receivedError: Error?

    func testWeatherByCoordinates_Success() {
        // Given
        let expectedWeather = Weather(temp: 12.34)
        let location = Location(name: "", lat: 0.0, lon: 0.0, country: "", state: "")

        let mockData = try! JSONEncoder().encode(expectedWeather)
        let mockResponse = HTTPURLResponse(url: URL(string: "https://example.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        let mockSession = MockURLSession(dataResult: (mockData, mockResponse), errorResult: nil)
        let weatherClient = WeatherClient(session: mockSession)

        // When
        let expectation = XCTestExpectation(description: "Fetch weather")
        
        Task {
            do {
                resultWeather = try await weatherClient.fetchWeather(location: location)
                expectation.fulfill()
            } catch {
                XCTFail("Unexpected error: \(error)")
            }
        }
        wait(for: [expectation], timeout: 5)

        // Then
        XCTAssertEqual(resultWeather, expectedWeather)
    }
    
    func testWeatherByCoordinates_NetworkError() {
        // Given
        let mockSession = MockURLSession(dataResult: nil, errorResult: NetworkError.invalidResponse)
        let weatherClient = WeatherClient(session: mockSession)
        let location = Location(name: "", lat: 0.0, lon: 0.0, country: "", state: "")

        // When
        let expectation = XCTestExpectation(description: "Fetch weather")
       
        Task {
            do {
                _ = try await weatherClient.fetchWeather(location: location)
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
