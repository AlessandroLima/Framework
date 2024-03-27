//
//  LocationTests.swift
//  WeatherSearchNewTests
//
//  Created by Alessandro Teixeira Lima on 14/02/24.
//

import XCTest

final class LocationTests: XCTestCase {

    func testDecoding() {
        let jsonString = """
        {
            "name": "City Name",
            "lat": 123.456,
            "lon": 123.456,
            "country": "Country Name",
            "state": "State Name"
        }
        """.data(using: .utf8)!
        
        let locationTest = try! JSONDecoder().decode(Location.self, from: jsonString)
        let location = Location(name: "City Name",
                                lat: 123.456 ,
                                lon: 123.456 ,
                                country: "Country Name" ,
                                state: "State Name")
        XCTAssertEqual(locationTest, location)
        
    }
    
}
