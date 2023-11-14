//
//  AlertViewUtils.swift
//  Gymondo
//
//  Created by mihmouda on 12/11/2023.
//

import UIKit
import SwiftUI

/// A SwiftUI view that represents an activity indicator.
struct ActivityIndicator: UIViewRepresentable {
    
    /// A binding to control the animation state of the activity indicator.
    @Binding var isAnimating: Bool
    
    /// The style of the activity indicator.
    let style: UIActivityIndicatorView.Style

    /// Creates a `UIActivityIndicatorView` with the specified style.
    ///
    /// - Parameter context: The context in which the view was created.
    /// - Returns: A `UIActivityIndicatorView` with the specified style.
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    /// Updates the state of the `UIActivityIndicatorView`.
    ///
    /// - Parameters:
    ///   - uiView: The `UIActivityIndicatorView` to update.
    ///   - context: The context in which the view was created.
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        // Start or stop the animation based on the isAnimating binding
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

