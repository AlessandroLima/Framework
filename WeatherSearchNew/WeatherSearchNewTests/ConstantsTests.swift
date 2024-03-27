//
//  ConstantsTests.swift
//  WeatherSearchNewTests
//
//  Created by Alessandro Teixeira Lima on 14/02/24.
//

import XCTest
@testable import WeatherSearchNew

final class ConstantsTests: XCTestCase {

    func testAPIKey() {
        XCTAssertEqual(Constants.Keys.APIKey, "3e40fae3f25784f4776d736951958715")
    }
    
    func testAPIUnit() {
        XCTAssertEqual(Constants.Keys.unit, "metric")
    }
}
