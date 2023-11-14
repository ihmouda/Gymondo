//
//  ExerciseItem.swift
//  Gymondo
//
//  Created by mihmouda on 10/11/2023.
//

import SwiftUI

/// A SwiftUI view for displaying an exercise item.
struct ExerciseItem: View {
    
    /// The exercise item to be displayed.
    var item: Exercise
    
    var body: some View {
        ZStack {
            // Display an asynchronous image with a random color overlay and rounded border
            AsyncImageView(urlString: item.images?.first?.imageURL)
                .overlay(
                    Rectangle()
                        .foregroundColor(Color.random(opacity: 0.5))
                )
                .overlay(
                    TitleTextView(text: item.name, font: .body.bold(), color: Color.white)
                )
                .dropRoundedBorder(borderWidth: item.images?.first?.imageURL == nil ? 0.0 : 0.5, cornerRadius: 10.0)
        }
    }
}

/// A preview of the ExerciseItem with a sample exercise.
struct ExerciseItem_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseItem(item: Exercise(id: 0, name: "Push-up", images: [], variations: []))
    }
}

extension Color {

    /// Generates a random color with the specified opacity.
    /// - Parameter opacity: The opacity value for the generated color.
    /// - Returns: A random color.
    static func random(opacity: Double = 1.0) -> Color {
        Color(
            red: .random(in: 0...0.9),
            green: .random(in: 0...0.9),
            blue: .random(in: 0...0.9),
            opacity: opacity
        )
    }
}
