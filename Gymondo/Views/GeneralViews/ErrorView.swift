//
//  ErrorView.swift
//  Gymondo
//
//  Created by mihmouda on 13/11/2023.
//

import SwiftUI

/// A SwiftUI view for displaying an error message with a retry action.
struct ErrorView<Content: View>: View {
    
    /// The action to be performed when the retry button is tapped.
    let action: () -> Void
    
    /// The content to be displayed alongside the error message.
    let content: () -> Content
    
    /// The label for the error message.
    let errorLabel: String

    /// Initializes an error view with the specified content, error label, and retry action.
    /// - Parameters:
    ///   - content: The content to be displayed alongside the error message.
    ///   - errorLabel: The label for the error message.
    ///   - action: The action to be performed when the retry button is tapped.
    init(@ViewBuilder content: @escaping () -> Content, errorLabel: String, action: @escaping () -> Void) {
        self.content = content
        self.action = action
        self.errorLabel = errorLabel
    }

    var body: some View {
        // Display the content with an alert containing the error message and a retry button
        content()
            .alert(errorLabel, isPresented: .constant(true)) {
                Button(action: self.action) {
                    Text("retry")
                }
            }
    }
}
