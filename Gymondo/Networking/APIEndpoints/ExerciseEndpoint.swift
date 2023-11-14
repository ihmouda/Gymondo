//
//  ExerciseEndpoint.swift
//  Gymondo
//
//  Created by mihmouda on 11/11/2023.
//

import Foundation

/// An enumeration representing API endpoints related to exercises.
enum ExerciseEndpoint: APIEndpoint {
    
    /// Retrieves a list of exercises.
    /// - Parameters:
    ///   - parameters: Optional parameters for the request.
    case getExercises(parameters: [String: Any]?)
    
    /// Retrieves details for a specific exercise.
    /// - Parameters:
    ///   - id: The unique identifier of the exercise.
    case getExercise(id: Int)

    /// The base URL for the exercise-related API endpoints.
    var baseURL: String {
        return "https://wger.de/api/v2"
    }
    
    /// The specific path for each exercise-related API endpoint.
    var path: String {
        switch self {
        case .getExercises:
            return "/exerciseinfo"
        case .getExercise(let id):
            return "/exerciseinfo/\(id)"
        }
    }
    
    /// The HTTP method to be used for each exercise-related API request.
    var method: HTTPMethod {
        switch self {
        case .getExercises, .getExercise:
            return .get
        }
    }
    
    /// The headers to be included in each exercise-related API request.
    var headers: [String: String]? {
        return nil
    }
    
    /// The name of the mock file to be used for testing purposes.
    var mockFile: String? {
        switch self {
        case .getExercises:
            return "exercises"
        case .getExercise:
            return "exercise"
        }
    }
    
    /// Converts the exercise-related API endpoint information into a URLRequest.
    ///
    /// - Returns: A URLRequest instance representing the exercise-related API request.
    func asURLRequest() -> URLRequest? {
        
        guard let url = URL(string: self.baseURL)?.appendingPathComponent(self.path)
        else { return nil }
        
        var components = URLComponents(string: url.absoluteString)!

        switch self {
        case .getExercises(let parameters):
            components.queryItems = parameters?.map { (key, value) in
                URLQueryItem(name: key, value: (value as? LosslessStringConvertible)?.description)
            }
        default:
            break
        }
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = self.method.rawValue
        self.headers?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }

        return request
    }
}
