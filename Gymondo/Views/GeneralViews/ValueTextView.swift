//
//  ValueTextView.swift
//  Gymondo
//
//  Created by mihmouda on 12/11/2023.
//

import SwiftUI

/// A SwiftUI view for displaying a value text with customizable font and frame.
struct ValueTextView: View {
    
    /// The text to be displayed.
    let text: String?
    
    /// The font to be applied to the text. If not provided, the default system font with size 10 will be used.
    let font: Font?
    
    var body: some View {
        Text(text ?? "") // Display the provided text or an empty string if nil
            .font(font ?? .system(size: 10)) // Apply the provided font or use the default system font with size 10
            .frame(maxWidth: .infinity, alignment: .leading) // Expand the text to the maximum width and left-align it
    }
}

// MARK: - Preview

/// A preview of the ValueTextView with default parameters.
struct ValueTextView_Previews: PreviewProvider {
    static var previews: some View {
        ValueTextView(text: nil, font: nil)
    }
}
