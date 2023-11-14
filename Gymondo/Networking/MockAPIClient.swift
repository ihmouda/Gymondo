//
//  MockAPIClient.swift
//  Gymondo
//
//  Created by mihmouda on 14/11/2023.
//

import Combine
import Foundation

/// A concrete implementation of the `APIClient` protocol that provides mock data for testing purposes.
class MockAPIClient: APIClient {
    
    /// Sends a request to the specified API endpoint and receives mock decodable response data.
    ///
    /// - Parameters:
    ///   - endpoint: The API endpoint to request.
    /// - Returns: A Combine publisher emitting the mock decodable response or an error.
    func request<T: Decodable>(_ endpoint: APIEndpoint) -> AnyPublisher<T, Error> {
        
        // Attempt to retrieve the filename for mock data from the API endpoint.
        guard let fileName = endpoint.mockFile,
            // Construct the URL for the mock data file from the app's bundle.
            let url = Bundle(for: Self.self).url(forResource: fileName, withExtension: "json") else {
                return Fail(error: APIError.invalidData).eraseToAnyPublisher()
        }
        
        // Use Combine publishers to load and decode mock data.
        return Optional(url)
            .publisher
            .tryMap { url in
                // Load mock data from the specified URL.
                guard let data = try? Data(contentsOf: url) else {
                    fatalError("Failed to load \(url) from bundle.")
                }
                return data
            }
            .mapError({ error in
                return error
            })
            .decode(type: T.self, decoder: JSONDecoder()) // Decode the mock data into the specified type.
            .eraseToAnyPublisher() // Erase publisher type for encapsulation.
    }
}
