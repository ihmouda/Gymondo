//
//  ExerciseImage.swift
//  Gymondo
//
//  Created by mihmouda on 09/11/2023.
//

import Foundation

/// ExerciseImage represents an image associated with an exercise in the application.
///
/// This struct conforms to the Decodable protocol, allowing it to be easily
/// decoded from JSON data.
struct ExerciseImage: Decodable {
    
    /// The unique identifier for the exercise image.
    let id: Int?
    
    /// The URL string representing the location of the exercise image.
    let imageURL: String?
    
    /// Coding keys enumeration to customize the decoding process.
    enum CodingKeys: String, CodingKey {
        /// The coding key for the `id` property.
        case id
        
        /// The coding key for the `imageURL` property, with a custom key name "image" in the JSON data.
        case imageURL = "image"
    }
}

