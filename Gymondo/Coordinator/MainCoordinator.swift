//
//  MainCoordinator.swift
//  Gymondo
//
//  Created by mihmouda on 09/11/2023.
//

import UIKit
import SwiftUI

/// MainCoordinator is responsible for coordinating the navigation flow in the application.
class MainCoordinator: Coordinator {
    
    /// The navigation controller associated with the coordinator.
    var navController: UINavigationController
    
    /// Initializes the MainCoordinator with the provided navigation controller.
    ///
    /// - Parameter navController: The navigation controller to be associated with the coordinator.
    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    /// Starts the main coordinator by setting up the initial view controller and navigation.
    ///
    /// This method configures the initial view controller (ExerciseListView) and pushes it onto
    /// the navigation stack. It also sets the title and back button for the view controller.
    func start() {
        
        // Create ExerciseListView with the current coordinator
        let view = ExerciseListView(coordinator: self)
        
        // Wrap the SwiftUI view in a UIHostingController
        let vc = UIHostingController(rootView: view)
        
        // Set the title for the view controller
        vc.title = String(localized: "exercises")
        
        // Customize the back button in the navigation bar
        vc.navigationItem.backBarButtonItem = UIBarButtonItem(
            title: String(localized: "back"),
            style: .plain,
            target: nil,
            action: nil)
        
        // Push the view controller onto the navigation stack
        self.navController.pushViewController(vc, animated: true)
    }
    
    /// Shows the detail view for a specific exercise.
    ///
    /// - Parameter id: The identifier of the exercise to display in the detail view.
    func showDetailView(id: Int) {
        
        // Create ExerciseDetailView with the provided exercise ID and current coordinator
        let view = ExerciseDetailView(exerciseID: id, coordinator: self)
        
        // Wrap the SwiftUI view in a UIHostingController
        let vc = UIHostingController(rootView: view)
        
        // Push the detail view controller onto the navigation stack
        self.navController.pushViewController(vc, animated: true)
    }
}
