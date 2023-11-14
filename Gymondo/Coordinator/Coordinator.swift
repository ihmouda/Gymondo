//
//  Coordinator.swift
//  Gymondo
//
//  Created by mihmouda on 09/11/2023.
//

import UIKit

/// Coordinator protocol defines the basic requirements for a coordinator object.
///
/// A coordinator is responsible for managing navigation and coordinating the flow
/// of the application. It typically interacts with a navigation controller to
/// handle transitions between different screens or view controllers.
protocol Coordinator {
    
    /// The navigation controller associated with the coordinator.
    var navController: UINavigationController { get set }
    
    /// Start the coordinator.
    ///
    /// This method is called to initiate the coordinator's activities. It may involve
    /// configuring initial view controllers, handling initial navigation, or setting up
    /// any necessary dependencies.
    func start()
}
