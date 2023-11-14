//
//  Exercise.swift
//  Gymondo
//
//  Created by mihmouda on 09/11/2023.
//

import Foundation

/// Exercise represents a model for an exercise in the application.
///
/// This struct conforms to the Decodable protocol, allowing it to be easily
/// decoded from JSON data. It also conforms to the Identifiable protocol, making
/// it suitable for use in SwiftUI lists and other constructs that require
/// identifiable items.
struct Exercise: Decodable, Identifiable {
    
    /// The unique identifier for the exercise.
    let id: Int?
    
    /// The name of the exercise.
    let name: String?
    
    /// The description of the exercise.
    var description: String?
    
    /// An array of ExerciseImage objects representing images associated with the exercise.
    let images: [ExerciseImage]?
    
    /// An array of variation IDs associated with the exercise.
    let variations: [Int]?
}
