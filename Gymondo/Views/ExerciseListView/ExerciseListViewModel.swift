//
//  ExerciseListViewModel.swift
//  Gymondo
//
//  Created by mihmouda on 11/11/2023.
//

import Combine
import Foundation

/// View model responsible for managing the data and state of the ExerciseListView.
class ExerciseListViewModel: ObservableObject {
    
    /// The set of cancellables to manage Combine publishers.
    private var cancellables = Set<AnyCancellable>()
    
    /// The service responsible for fetching exercises.
    let exerciseService: ExerciseServiceProtocol
    
    /// Published property for the loading state of the view.
    @Published private(set) var loadingState = LoadingState.idle

    /// Initializes the view model with a given exercise service.
    /// - Parameter exerciseService: The service responsible for fetching exercises.
    init(exerciseService: ExerciseServiceProtocol) {
        self.exerciseService = exerciseService
    }
    
    /// Fetches exercises from the exercise service.
    func fetchExercises() {
        // Set the loading state to indicate data retrieval is in progress
        self.loadingState = .loading
        
        // Use the exercise service to fetch exercises
        exerciseService.getExercises(parameters: [:])
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                // Handle completion events, such as errors
                switch completion {
                case .failure(let error):
                    // If there's an error, set the loading state to failed
                    self.loadingState = LoadingState.failed(error)
                default:
                    break
                }
                
            }, receiveValue: {[weak self] data in
                // If data is received successfully, set the loading state to loaded
                self?.loadingState = .loaded(T: data)
            }).store(in: &cancellables)
    }
}

