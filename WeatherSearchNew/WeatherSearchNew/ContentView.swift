//
//  ContentView.swift
//  WeatherSearchNew
//
//  Created by Alessandro Teixeira Lima on 13/02/24.
//

import SwiftUI
import Weather

struct ContentView: View {
    
    @State private var city: String = ""
    @State private var isFetchingWeather: Bool = false
    @State private var weather: Temp?
    
    let geocodingClient = GeocodingClient()
    let weatherClient = WeatherClient()
    
    private func fetchWeather() async {
        
        do {
            guard let location = try await geocodingClient.coordinateByCity(city) else { return }
            weather = try await weatherClient.fetchWeather(location: location)
        } catch {
            print(error)
            return
        }
    }
    
    var body: some View {
        
        VStack {
            TextField("City: ", text: $city)
                .textFieldStyle(.roundedBorder)
                .onSubmit{
                    isFetchingWeather = true
                }.task (id: isFetchingWeather) {
                    if isFetchingWeather {
                        await fetchWeather()
                        isFetchingWeather = false
                        city = ""
                    }
                }
            Spacer()
            if let weather {
                Text(MeasurementFormarter.temperature(value: weather.temp))
                    .font(.system(size: 50))
            }
            Spacer()
            
        }.padding()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

