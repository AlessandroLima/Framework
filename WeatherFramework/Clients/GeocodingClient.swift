//
//  GeocodingClient.swift
//  WeatherSearchNew
//
//  Created by Alessandro Teixeira Lima on 13/02/24.
//


import Foundation

enum NetworkError: Error {
    case invalidResponse
}

protocol URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

struct URLSessionWrapper: URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse) {
        return try await URLSession.shared.data(from: url)
    }
}

struct GeocodingClient {
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSessionWrapper()) {
        self.session = session
    }
    
    func coordinateByCity(_ city: String) async throws -> Location? {
        let (data, response) = try await session.data(from: APIEndPoint.endPointURL(for: .coordinatesByLocationName(city)))
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        let locations = try JSONDecoder().decode([Location].self, from: data)
        return locations.first
    }
}
