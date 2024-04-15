//
//  ContentView.swift
//  WeatherSearchNew
//
//  Created by Alessandro Teixeira Lima on 13/02/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var city: String = ""
    @State private var isFetchingWeather: Bool = false
    @State private var temperature: Temp?
    
    private var weather: Weather?
    
    init(weather: Weather) {
        self.weather = weather
        self.temperature = weather.getTemp()
    }
    
    private func fetchWeather() async {
        
        do {
            
            if let weather = weather {
                guard let location = try await weather.geocodingClient.coordinateByCity(city)  else { return }
                temperature = try await weather.weatherClient.fetchWeather(location: location)
            }
            
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
            if let temperature {
                Text(MeasurementFormarter.temperature(value: temperature.temp))
                    .font(.system(size: 50))
            }
            Spacer()
            
        }.padding()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(weather: Weather())
    }
}

