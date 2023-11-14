//
//  ExerciseListTests.swift
//  GymondoTests
//
//  Created by mihmouda on 13/11/2023.
//

import XCTest
import Combine
import SwiftUI
@testable import Gymondo

/// Test case class for testing the ExerciseListView and its associated components.
final class ExerciseListTests: XCTestCase {
    
    // MARK: - Properties
    
    private var expectation: XCTestExpectation!
    private var exerciseService: ExerciseService!
    
    private var coordinator: MainCoordinator!
    private var sutViewModel: ExerciseListViewModel!
    private var sutView: ExerciseListView!
    private var sutViewController: UIHostingController<ExerciseListView>!
    
    // MARK: - Test Setup and Teardown
    
    override func setUpWithError() throws {
        expectation = expectation(description: "Success: Get Exercises")
        
        // Set up the view model with a mock exercise service
        sutViewModel = ExerciseListViewModel(exerciseService: ExerciseService(apiClient: MockAPIClient()))
        
        // Set up the main coordinator
        coordinator = MainCoordinator(navController: UINavigationController())
        
        // Set up the ExerciseListView and its associated UIHostingController
        sutView = ExerciseListView(coordinator: coordinator, viewModel: self.sutViewModel)
        sutViewController = UIHostingController(rootView: sutView)
        sutViewController.title = String(localized: "exercises")
        sutViewController.loadView()
    }
    
    override func tearDownWithError() throws {
        // Clean up resources after each test
        self.expectation = nil
        self.coordinator = nil
        self.sutView = nil
        self.sutViewModel = nil
        self.sutViewController = nil
    }
    
    // MARK: - Test Cases
    
    /// Test case to verify the retrieval of exercises.
    func testGetExercises() throws {
        
        // Initial assertions
        XCTAssertEqual(sutViewController.title, String(localized: "exercises"))
        XCTAssertNotNil(sutView.viewModel)
        XCTAssertEqual(sutView.viewModel.loadingState, .idle)
        
        // Trigger the fetchExercises method
        sutView.viewModel.fetchExercises()
        XCTAssertEqual(sutView.viewModel.loadingState, .loading)
        
        // Delayed assertion to check the loading state after a short delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            
            switch self.sutView.viewModel.loadingState {
            case .loaded(let data):
                // Assert that the data is not nil and contains exercises
                XCTAssertNotNil(data)
                XCTAssertGreaterThan((data as? ExerciseResponse)?.exercises.count ?? -1, 0)
                self.expectation.fulfill()
                break
            default:
                // If the loading state is not .loaded, fail the test
                XCTFail("Error")
                self.expectation.fulfill()
            }
        })
        
        // Wait for the expectation to be fulfilled within a timeout
        wait(for: [expectation], timeout: 10.0)
    }
}
