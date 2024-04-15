//
//  WeatherSearchNewApp.swift
//  WeatherSearchNew
//
//  Created by Alessandro Teixeira Lima on 13/02/24.
//

import SwiftUI
import WeatherFramework

@main
struct WeatherSearchNewApp: App {
    
    let weather = Weather()
    
    var body: some Scene {
        WindowGroup {
            ContentView(weather: self.weather)
        }
    }
}
