//
//  TitleTextView.swift
//  Gymondo
//
//  Created by mihmouda on 12/11/2023.
//

import SwiftUI

/// A SwiftUI view for displaying a title text with customizable font and color.
struct TitleTextView: View {
    
    /// The text to be displayed.
    let text: String?
    
    /// The font to be applied to the text. If not provided, the default system font with size 10 will be used.
    let font: Font?
    
    /// The color of the text. If not provided, the default text color will be used.
    let color: Color?
    
    var body: some View {
        Text(text ?? "") // Display the provided text or an empty string if nil
            .font(font ?? .system(size: 10)) // Apply the provided font or use the default system font with size 10
            .foregroundColor(color) // Apply the provided color or use the default text color
            .multilineTextAlignment(.center) // Center-align the text if it spans multiple lines
    }
}

// MARK: - Preview

/// A preview of the TitleTextView with default parameters.
struct TitleTextView_Previews: PreviewProvider {
    static var previews: some View {
        TitleTextView(text: nil, font: nil, color: nil)
    }
}
