//
//  ExerciseService.swift
//  Gymondo
//
//  Created by mihmouda on 11/11/2023.
//

import Combine

/// A protocol defining the interface for an exercise service that communicates with an API.
protocol ExerciseServiceProtocol {
    
    /// Fetches a list of exercises based on the specified parameters.
    ///
    /// - Parameters:
    ///   - parameters: Optional parameters for filtering exercises.
    /// - Returns: A Combine publisher emitting the response containing a list of exercises or an error.
    func getExercises(parameters: [String: String]?) -> AnyPublisher<ExerciseResponse, Error>
    
    /// Fetches detailed information about a specific exercise.
    ///
    /// - Parameters:
    ///   - id: The unique identifier of the exercise.
    /// - Returns: A Combine publisher emitting the response containing detailed information about the exercise or an error.
    func getExerciseInfo(id: Int) -> AnyPublisher<Exercise, Error>
}

/// A concrete implementation of the `ExerciseServiceProtocol` that uses an API client for network requests.
class ExerciseService: ExerciseServiceProtocol {

    /// The API client responsible for making network requests.
    var apiClient: APIClient
    
    /// Initializes an exercise service with the provided API client.
    ///
    /// - Parameters:
    ///   - apiClient: The API client for making network requests.
    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }
    
    func getExercises(parameters: [String: String]?) -> AnyPublisher<ExerciseResponse, Error> {
        // Delegate the request to the underlying API client using the appropriate API endpoint.
        return apiClient.request(ExerciseEndpoint.getExercises(parameters: parameters))
    }
    
    func getExerciseInfo(id: Int) -> AnyPublisher<Exercise, Error> {
        // Delegate the request to the underlying API client using the appropriate API endpoint.
        return apiClient.request(ExerciseEndpoint.getExercise(id: id))
    }
}
