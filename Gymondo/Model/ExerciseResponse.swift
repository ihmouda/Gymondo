//
//  ExerciseResponse.swift
//  Gymondo
//
//  Created by mihmouda on 09/11/2023.
//

import Foundation

/// ExerciseResponse represents the response structure for exercise data from an external API.
///
/// This struct conforms to the Decodable protocol, allowing it to be easily
/// decoded from JSON data.
struct ExerciseResponse: Decodable {
    
    /// An array of Exercise objects representing the exercises retrieved from the API.
    let exercises: [Exercise]
    
    /// Coding keys enumeration to customize the decoding process.
    enum CodingKeys: String, CodingKey {
        /// The coding key for the `exercises` property, with a custom key name "results" in the JSON data.
        case exercises = "results"
    }
}
