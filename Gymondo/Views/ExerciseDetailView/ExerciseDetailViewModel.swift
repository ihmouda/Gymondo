//
//  ExerciseDetailViewModel.swift
//  Gymondo
//
//  Created by mihmouda on 12/11/2023.
//

import Combine
import Foundation

/// View model responsible for managing the data and state of the ExerciseDetailView.
class ExerciseDetailViewModel: ObservableObject {
    
    /// The set of cancellables to manage Combine publishers.
    private var cancellables = Set<AnyCancellable>()
    
    /// The service responsible for fetching exercise details.
    let exerciseService: ExerciseServiceProtocol
    
    /// Published property for the title of the exercise.
    @Published private(set) var title: String?
    
    /// Published property for the loading state of the view.
    @Published private(set) var loadingState = LoadingState.idle

    /// Initializes the view model with a given exercise service.
    /// - Parameter exerciseService: The service responsible for fetching exercise details.
    init(exerciseService: ExerciseServiceProtocol) {
        self.exerciseService = exerciseService
    }
    
    /// Fetches exercise information with the given ID.
    /// - Parameter id: The unique identifier of the exercise.
    func fetchExerciseInfoWithID(_ id: Int) {
        // Set the loading state to indicate data retrieval is in progress
        self.loadingState = .loading
        
        // Use the exercise service to fetch exercise details
        self.exerciseService.getExerciseInfo(id: id)
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
                // Set the title to the name of the exercise
                self?.title = data.name
            }).store(in: &self.cancellables)
    }
}
