//
//  MockURLSession.swift
//  WeatherSearchNewTests
//
//  Created by Alessandro Teixeira Lima on 16/02/24.
//

import Foundation

struct MockURLSession: URLSessionProtocol {
    var dataResult: (Data, URLResponse)?
    var errorResult: Error?

    func data(from url: URL) async throws -> (Data, URLResponse) {
        if let error = errorResult {
            throw error
        }
        guard let dataResult = dataResult else {
            fatalError("You must set dataResult for MockURLSession")
        }
        return dataResult
    }
}
