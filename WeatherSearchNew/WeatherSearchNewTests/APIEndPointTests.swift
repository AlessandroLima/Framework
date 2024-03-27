//
//  APIEndPointTests.swift
//  WeatherSearchNewTests
//
//  Created by Alessandro Teixeira Lima on 14/02/24.
//

import XCTest

@testable import WeatherSearchNew

class APIEndPointTests: XCTestCase {
    
    func testCoordinatesByLocationName() {
        let endPoint = APIEndPoint.coordinatesByLocationName("London")
        let url = APIEndPoint.endPointURL(for: endPoint)
        XCTAssertEqual(url.absoluteString, "\(APIEndPoint.baseURL)/geo/1.0/direct?q=London&appid=\(Constants.Keys.APIKey)")
        
    }
    
    func testWeatherByLatLong() {
        let endPoint = APIEndPoint.weatherByLatLong(51.5074, -0.1278)
        let url = APIEndPoint.endPointURL(for: endPoint)
        
        XCTAssertEqual(url.absoluteString, "\(APIEndPoint.baseURL)/data/2.5/weather?lat=51.5074&lon=-0.1278&unit=\(Constants.Keys.unit)&appid=\(Constants.Keys.APIKey)")
        
    }
}
