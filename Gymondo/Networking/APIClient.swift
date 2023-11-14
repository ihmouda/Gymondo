//
//  APIClient.swift
//  Gymondo
//
//  Created by mihmouda on 11/11/2023.
//

import Combine

/// A protocol representing an API client for making network requests.
protocol APIClient {
    
    /// Sends a request to the specified API endpoint and receives a decodable response.
    ///
    /// - Parameters:
    ///   - endpoint: The API endpoint to request.
    /// - Returns: A Combine publisher emitting the decodable response or an error.
    func request<T: Decodable>(_ endpoint: APIEndpoint) -> AnyPublisher<T, Error>
}
