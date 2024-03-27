//
//  Weather.swift
//  WeatherSearchNew
//
//  Created by Alessandro Teixeira Lima on 13/02/24.
//

import Foundation

struct WeatherResponse: Codable, Equatable {
    var main:       Weather
    
    static func ==(lhs: WeatherResponse, rhs: WeatherResponse) -> Bool {
        return lhs.main == rhs.main
    }
}


public struct Weather: Codable, Equatable {
    
    public var temp:       Double
    
    public static func ==(lhs: Weather, rhs: Weather) -> Bool {
        return lhs.temp == rhs.temp
    }
}

