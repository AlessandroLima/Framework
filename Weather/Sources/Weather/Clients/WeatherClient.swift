//
//  WeatherClient.swift
//  WeatherSearchNew
//
//  Created by Alessandro Teixeira Lima on 16/02/24.
//

import Foundation

public struct WeatherClient {
    
    let session: URLSessionProtocol
    
    public init(session: URLSessionProtocol = URLSessionWrapper()) {
        self.session = session
    }
    
    public func fetchWeather(location: Location) async throws -> Temp {
        let url = APIEndPoint.endPointURL(for: .weatherByLatLong(location.lat ?? 0.0, location.lon ?? 0.0))
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
        
        return weatherResponse.main
    }
}
