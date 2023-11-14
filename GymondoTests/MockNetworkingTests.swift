//
//  MockNetworkingTests.swift
//  GymondoTests
//
//  Created by mihmouda on 14/11/2023.
//

import XCTest
import Combine
import SwiftUI
@testable import Gymondo

/// Test case class for testing the networking layer with a mock API client.
final class MockNetworkingTests: XCTestCase {

    // MARK: - Properties
    
    private var expectation: XCTestExpectation!
    private var exerciseService: ExerciseService!
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Test Setup and Teardown
    
    override func setUpWithError() throws {
        // Set up the expectation for asynchronous testing
        expectation = expectation(description: "Success: Get Exercises")
        
        // Initialize the ExerciseService with a mock API client
        self.exerciseService = ExerciseService(apiClient: MockAPIClient())
    }

    override func tearDownWithError() throws {
        // Clean up resources after each test
        expectation = nil
        self.exerciseService = nil
        cancellables.forEach { $0.cancel() }
    }

    // MARK: - Test Cases
    
    /// Test case to verify the successful retrieval of exercises.
    func testGetExercises() throws {
        
        // Subscribe to the getExercises publisher and handle the received values and completion
        self.exerciseService.getExercises(parameters: nil)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    // If there's an error, fail the test with the error title
                    XCTFail((error as? APIError)?.title ?? "Error")
                    self.expectation.fulfill()
                default:
                    // If there's no error, do nothing for completion
                    break
                }
            }, receiveValue: {[weak self] data in
                // Assert that the received data is not nil and contains exercises
                XCTAssertNotNil(data)
                XCTAssertGreaterThan(data.exercises.count, 0)
                self?.expectation.fulfill()
            }).store(in: &cancellables)
        
        // Wait for the expectation to be fulfilled within a timeout
        wait(for: [expectation], timeout: 10.0)
    }
    
    /// Test case to verify the successful retrieval of exercise details.
    func testGetExerciseDetail() throws {
        
        // Subscribe to the getExerciseInfo publisher and handle the received values and completion
        self.exerciseService.getExerciseInfo(id: 1314)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    // If there's an error, fail the test with the error title
                    XCTFail((error as? APIError)?.title ?? "Error")
                    self.expectation.fulfill()
                default:
                    // If there's no error, do nothing for completion
                    break
                }
            }, receiveValue: {[weak self] data in
                // Assert that the received data is not nil and has the expected ID
                XCTAssertNotNil(data)
                XCTAssertEqual(data.id, 1314)
                self?.expectation.fulfill()
            }).store(in: &cancellables)
        
        // Wait for the expectation to be fulfilled within a timeout
        wait(for: [expectation], timeout: 10.0)
    }
}
