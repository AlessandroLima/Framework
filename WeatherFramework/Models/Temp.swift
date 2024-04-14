//
//  Weather.swift
//  WeatherSearchNew
//
//  Created by Alessandro Teixeira Lima on 13/02/24.
//

import Foundation

struct WeatherResponse: Codable, Equatable {
    var main:       Temp
    
    static func ==(lhs: WeatherResponse, rhs: WeatherResponse) -> Bool {
        return lhs.main == rhs.main
    }
}


public struct Temp: Codable, Equatable {
    
    public var temp:       Double
    
    public static func ==(lhs: Temp, rhs: Temp) -> Bool {
        return lhs.temp == rhs.temp
    }
}

