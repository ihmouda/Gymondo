//
//  ExerciseDetailTests.swift
//  GymondoTests
//
//  Created by mihmouda on 14/11/2023.
//

import XCTest
import Combine
import SwiftUI
@testable import Gymondo

/// Test case class for testing the ExerciseDetailView and its associated components.
final class ExerciseDetailTests: XCTestCase {
    
    // MARK: - Properties
    
    private var expectation: XCTestExpectation!
    private var exerciseService: ExerciseService!
    private var coordinator: MainCoordinator!

    private var sutViewModel: ExerciseDetailViewModel!
    private var sutView: ExerciseDetailView!
    private var sutViewController: UIHostingController<ExerciseDetailView>!
    
    // MARK: - Test Setup and Teardown
    
    override func setUpWithError() throws {
        expectation = expectation(description: "Success: Get Exercise Detail")
        
        // Set up the main coordinator
        coordinator = MainCoordinator(navController: UINavigationController())
        
        // Set up the view model with a mock exercise service
        sutViewModel = ExerciseDetailViewModel(exerciseService: ExerciseService(apiClient: MockAPIClient()))
        
        // Set up the ExerciseDetailView and its associated UIHostingController
        sutView = ExerciseDetailView(exerciseID: 1314, coordinator: coordinator, viewModel: self.sutViewModel)
        sutViewController = UIHostingController(rootView: sutView)
        sutViewController.loadView()
    }
    
    override func tearDownWithError() throws {
        // Clean up resources after each test
        self.coordinator = nil
        self.sutView = nil
        self.sutViewModel = nil
        self.sutViewController = nil
    }
    
    // MARK: - Test Cases
    
    /// Test case to verify the retrieval of exercise details.
    func testGetExerciseDetail() throws {
        
        // Initial assertions
        XCTAssertNotNil(sutView.viewModel)
        XCTAssertEqual(sutView.viewModel.loadingState, .idle)
        
        // Trigger the fetchExerciseInfoWithID method
        sutView.viewModel.fetchExerciseInfoWithID(sutView.exerciseID)
        XCTAssertEqual(sutView.viewModel.loadingState, .loading)
        
        // Delayed assertion to check the loading state after a short delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            
            switch self.sutView.viewModel.loadingState {
            case .loaded(let data):
                // Assert that the data is not nil and contains exercise details
                XCTAssertNotNil(data)
                XCTAssertEqual((data as? Exercise)?.id ?? 0, self.sutView.exerciseID)
                XCTAssertNotNil((data as? Exercise)?.name)
                
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
