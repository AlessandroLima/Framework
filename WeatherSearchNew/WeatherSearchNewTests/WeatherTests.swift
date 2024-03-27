//
//  WeatherTests.swift
//  WeatherSearchNewTests
//
//  Created by Alessandro Teixeira Lima on 14/02/24.
//

import XCTest

final class WeatherTests: XCTestCase {

    func testDecoding() {
        let jsonString = """
        {
            "main": {
                "temp": 284.18
            }
        }
        """.data(using: .utf8)!
        
        let weatherTest = try! JSONDecoder().decode(WeatherResponse.self, from: jsonString)
        
        let weather = WeatherResponse(main: Weather(temp: 284.18))
        
        XCTAssertEqual(weatherTest, weather)
        
    }
}
