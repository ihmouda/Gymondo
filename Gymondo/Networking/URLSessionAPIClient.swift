//
//  URLSessionAPIClient.swift
//  Gymondo
//
//  Created by mihmouda on 11/11/2023.
//

import Combine
import Foundation

/// A concrete implementation of the `APIClient` protocol using URLSession for network requests.
class URLSessionAPIClient: APIClient {
    
    /// Sends a request to the specified API endpoint and receives a decodable response.
    ///
    /// - Parameters:
    ///   - endpoint: The API endpoint to request.
    /// - Returns: A Combine publisher emitting the decodable response or an error.
    func request<T: Decodable>(_ endpoint: APIEndpoint) -> AnyPublisher<T, Error> {
        
        // Attempt to create a URLRequest from the provided API endpoint.
        guard let urlRequest = endpoint.asURLRequest()
        else { return Fail(error: APIError.invalidData).eraseToAnyPublisher() }
        
        // Use URLSession dataTaskPublisher to perform the network request.
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .subscribe(on: DispatchQueue.global(qos: .background)) // Perform the request in the background.
            .tryMap { data, response -> Data in
                // Check if the response status code is within the success range.
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    throw APIError.invalidResponse
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder()) // Decode the received data into the specified type.
            .eraseToAnyPublisher() // Erase publisher type for encapsulation.
    }
}
