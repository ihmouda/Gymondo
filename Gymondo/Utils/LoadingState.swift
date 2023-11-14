//
//  LoadingState.swift
//  Gymondo
//
//  Created by mihmouda on 11/11/2023.
//

import Foundation

/// An enumeration representing the loading state of a view that fetches data asynchronously.
enum LoadingState: Equatable {
    
    /// Indicates that the view is in an idle state, with no data retrieval in progress.
    case idle
    
    /// Indicates that data retrieval is in progress.
    case loading
    
    /// Indicates that data retrieval failed with an associated error.
    case failed(Error)
    
    /// Indicates that data retrieval is complete, and the associated data is loaded.
    case loaded(T: Decodable)
    
    /// Compares two loading states for equality.
    ///
    /// - Parameters:
    ///   - lhs: The left-hand side loading state.
    ///   - rhs: The right-hand side loading state.
    /// - Returns: `true` if the loading states are equal; otherwise, `false`.
    static func == (lhs: LoadingState, rhs: LoadingState) -> Bool {
        switch (lhs, rhs) {
        case (.loaded(_), .loaded(_)):
            return true
        case (.failed(_), .failed(_)):
            return true
        case (.idle, .idle):
            return true
        case (.loading, .loading):
            return true
        default:
            return false
        }
    }
}

