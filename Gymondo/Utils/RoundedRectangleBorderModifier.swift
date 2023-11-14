//
//  ShadowBorderModifier.swift
//  Gymondo
//
//  Created by mihmouda on 12/11/2023.
//

import SwiftUI

/// A view modifier that adds a rounded border to the view.
struct RoundedBorderModifier: ViewModifier {
    
    /// The width of the border.
    let borderWidth: CGFloat
    
    /// The corner radius of the rounded border.
    let cornerRadius: CGFloat
    
    /// Applies the modification to the provided content.
    ///
    /// - Parameter content: The content view to be modified.
    /// - Returns: The modified content view with a rounded border.
    func body(content: Content) -> some View {
        content
            .cornerRadius(10)
            .frame(width: 110.0, height: 110.0)
            .overlay(RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(Color.gray, lineWidth: borderWidth))
                .shadow(radius: 1)
    }
}

extension View {
    
    /// Adds a rounded border to the view.
    ///
    /// - Parameters:
    ///   - borderWidth: The width of the border.
    ///   - cornerRadius: The corner radius of the rounded border.
    /// - Returns: The modified view with a rounded border.
    func dropRoundedBorder(borderWidth: CGFloat, cornerRadius: CGFloat) -> some View {
        ModifiedContent(content: self,
                        modifier: RoundedBorderModifier(borderWidth: borderWidth, cornerRadius: cornerRadius))
    }
}
