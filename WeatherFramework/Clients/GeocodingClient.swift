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

@available(iOS 15.0.0, *)
public protocol URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

@available(iOS 15.0.0, *)
public struct URLSessionWrapper: URLSessionProtocol {
    public init() {}
    public func data(from url: URL) async throws -> (Data, URLResponse) {
        return try await URLSession.shared.data(from: url)
    }
}

@available(iOS 15.0.0, *)
public struct GeocodingClient {
    
    let session: URLSessionProtocol
    
    public init(session: URLSessionProtocol = URLSessionWrapper()) {
        self.session = session
    }
    
    public func coordinateByCity(_ city: String) async throws -> Location? {
        let (data, response) = try await session.data(from: APIEndPoint.endPointURL(for: .coordinatesByLocationName(city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")))
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        let locations = try JSONDecoder().decode([Location].self, from: data)
        return locations.first
    }
}
