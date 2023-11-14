//
//  HTMLTextView.swift
//  Gymondo
//
//  Created by mihmouda on 14/11/2023.
//

import SwiftUI

/// A SwiftUI view for rendering HTML content.
struct HTMLTextView: View {
    
    /// The HTML content to be rendered.
    var html: String = ""

    /// The body of the view, containing the rendered HTML content.
    var body: some View {

        if let nsAttributedString = try? NSAttributedString(data: Data(html.utf8), options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil),
           let attributedString = try? AttributedString(nsAttributedString, including: \.uiKit) {
            // Display the attributed string if HTML parsing is successful
            Text(attributedString)
        } else {
            // Fallback: display the raw HTML content if parsing fails
            Text(html)
        }
    }
}

