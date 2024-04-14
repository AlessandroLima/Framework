//
//  MeasurementFormarter+Extension.swift
//  WeatherSearchNew
//
//  Created by Alessandro Teixeira Lima on 16/02/24.
//

import Foundation

public final class MeasurementFormarter {
    
    public static func temperature(value: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 0
        let formatter = MeasurementFormatter()
        formatter.numberFormatter = numberFormatter
        let temp = Measurement(value: value, unit: UnitTemperature.celsius)
        return formatter.string(from: temp)
        
    }
}
