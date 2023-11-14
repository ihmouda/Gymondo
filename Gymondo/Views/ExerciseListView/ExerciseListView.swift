//
//  ExerciseListView.swift
//  Gymondo
//
//  Created by mihmouda on 09/11/2023.
//

import SwiftUI

/// A SwiftUI view for displaying a list of exercises.
struct ExerciseListView: View {
    
    /// The coordinator responsible for navigating to other views.
    var coordinator: MainCoordinator?
    
    /// The view model responsible for managing the data and state of the exercise list view.
    @StateObject var viewModel = ExerciseListViewModel(exerciseService: ExerciseService(apiClient: URLSessionAPIClient()))

    /// The grid columns configuration for displaying exercises.
    let gridColumns = [
        GridItem(.flexible(minimum: 40), spacing: 0),
        GridItem(.flexible(minimum: 40), spacing: 0),
        GridItem(.flexible(minimum: 40), spacing: 0)
    ]
    
    var body: some View {
        
        switch viewModel.loadingState {
            
        case .loading:
            // Display an activity indicator while loading data
            ActivityIndicator(isAnimating: .constant(true), style: .medium)
            
        case .loaded(let data):
            // Display a grid of exercise items when data is loaded
            ScrollView {
                LazyVGrid(columns: gridColumns, alignment: .center, spacing: 10) {
                    ForEach((data as? ExerciseResponse)?.exercises ?? []) { exercise in
                        // Display each exercise item in the grid
                        ExerciseItem(item: exercise)
                            .onTapGesture {
                                // Trigger navigation to exercise detail view on tap
                                coordinator?.showDetailView(id: exercise.id ?? 0)
                            }
                    }
                }
            }
            
        case .idle:
            // Fetch exercises when the view appears
            Color.clear.onAppear(perform: viewModel.fetchExercises)
            
        case .failed(let error):
            // Display an error view with a retry option
            ErrorView(content: {
                Text("error_loading_data")
            }, errorLabel: (error as? APIError)?.title ?? "") {
                self.viewModel.fetchExercises()
            }
        }
    }
}

// MARK: - Preview

/// A preview of the ExerciseListView.
struct ExerciseListView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseListView()
    }
}
