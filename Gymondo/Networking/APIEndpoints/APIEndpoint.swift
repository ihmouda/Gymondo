//
//  APIEndpoint.swift
//  Gymondo
//
//  Created by mihmouda on 11/11/2023.
//

import Foundation
import SwiftUI

/// A protocol representing an API endpoint with essential information.
protocol APIEndpoint {
    
    /// The base URL for the API endpoint.
    var baseURL: String { get }
    
    /// The specific path for the API endpoint.
    var path: String { get }
    
    /// The HTTP method to be used for the API request.
    var method: HTTPMethod { get }
    
    /// The headers to be included in the API request.
    var headers: [String: String]? { get }
    
    /// The name of the mock file to be used for testing purposes.
    var mockFile: String? { get }

    /// Converts the API endpoint information into a URLRequest.
    ///
    /// - Returns: A URLRequest instance representing the API request.
    func asURLRequest() -> URLRequest?
}

/// An enumeration representing the HTTP methods for API requests.
enum HTTPMethod: String {
    case get = "GET"
}

/// An enumeration representing possible errors during API interactions.
enum APIError: Error {
    
    /// Indicates that the API response is invalid.
    case invalidResponse
    
    /// Indicates that the API data is invalid.
    case invalidData
    
    /// A human-readable title for the error.
    var title: String {
        switch self {
        case .invalidData:
            return String(localized: "invalid_data")
        case .invalidResponse:
            return String(localized: "invalid_response")
        }
    }
}
