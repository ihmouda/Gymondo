//
//  AsyncImageView.swift
//  Gymondo
//
//  Created by mihmouda on 10/11/2023.
//

import SwiftUI

/// A SwiftUI view for asynchronously loading and displaying images from a given URL.
struct AsyncImageView: View {
    
    /// The URL string for the image.
    var urlString: String?
    
    /// The system image name to be used as a placeholder if the image is not loaded yet.
    var imagePlaceholder: String = "photo"

    var body: some View {
        AsyncImage(url: URL(string: urlString ?? "")) { image in
            // If the image is loaded, display it and make it resizable
            image
                .resizable()
        } placeholder: {
            // If the image is not loaded, display a placeholder using a system image
            ZStack {
                Image(systemName: imagePlaceholder)
                    .resizable()
                    .foregroundColor(Color.init(uiColor: UIColor.lightGray))
            }
        }
    }
}

// MARK: - Preview

/// A preview of the AsyncImageView with default parameters.
struct AsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageView()
    }
}
