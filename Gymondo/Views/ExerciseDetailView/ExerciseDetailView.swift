//
//  ExerciseDetailView.swift
//  Gymondo
//
//  Created by mihmouda on 09/11/2023.
//

import SwiftUI

/// A SwiftUI view for displaying detailed information about a specific exercise.
struct ExerciseDetailView: View {
    
    /// The unique identifier for the exercise.
    var exerciseID: Int
    
    /// The coordinator responsible for navigating to other views.
    var coordinator: MainCoordinator?
    
    /// The view model responsible for managing the data and state of the exercise detail view.
    @StateObject var viewModel = ExerciseDetailViewModel(exerciseService: ExerciseService(apiClient: URLSessionAPIClient()))

    /// The grid columns configuration for displaying exercise variations.
    let columns = [
        GridItem(.flexible(minimum: 40), spacing: 0),
        GridItem(.flexible(minimum: 40), spacing: 0),
        GridItem(.flexible(minimum: 40), spacing: 0),
        GridItem(.flexible(minimum: 40), spacing: 0),
        GridItem(.flexible(minimum: 40), spacing: 0)
    ]
    
    var body: some View {
        Group {
            switch viewModel.loadingState {
            case .loading:
                ActivityIndicator(isAnimating: .constant(true), style: .medium)
                
            case .loaded(let data):
                ScrollView {
                    VStack(spacing: 10) {
                        let exercise = data as? Exercise

                        // Display images horizontally in a scrollable TabView
                        if let images = exercise?.images, images.count > 0 {
                            ScrollView(.horizontal, showsIndicators: false) {
                                TabView {
                                    ForEach(exercise?.images ?? [], id: \.id) { img in
                                        AsyncImageView(urlString: img.imageURL ?? "", imagePlaceholder: "figure.walk.circle.fill")
                                            .scaledToFit()
                                            .padding(.horizontal, 20)
                                    }
                                }
                                .frame(width: UIScreen.main.bounds.width - 10, height: 200)
                                .tabViewStyle(.page)
                                .indexViewStyle(.page(backgroundDisplayMode: .always))
                            }
                        }
                        
                        // Display exercise description using HTMLTextView
                        HTMLTextView(html: exercise?.description ?? "")
                            .multilineTextAlignment(.leading)
                        
                        // Display exercise variations in a LazyVGrid
                        if let variations = exercise?.variations, variations.count > 0 {
                            Text("variations")
                                .font(.title3)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            ScrollView {
                                LazyVGrid(columns: columns, alignment: .center, spacing: 10) {
                                    ForEach((data as? Exercise)?.variations ?? [], id:\.self) { variation in
                                        Text(variation.description)
                                            .frame(minWidth: 50, maxWidth: 70)
                                            .background(.blue)
                                            .foregroundColor(.white)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                            .onTapGesture {
                                                self.coordinator?.showDetailView(id: variation)
                                            }
                                    }
                                }
                            }
                        }

                        Spacer()
                    }
                }
                .padding()
                
            case .idle:
                Color.clear.onAppear(perform: fetchExerciseInfoWithID)
                
            case .failed(let error):
                // Display an error view with a retry option
                ErrorView(content: {
                    Text("error_loading_data")
                }, errorLabel: (error as? APIError)?.title ?? "") {
                    self.fetchExerciseInfoWithID()
                }
            }
        }
        .navigationTitle(self.viewModel.title ?? "")
    }
    
    /// Fetch exercise information using the view model.
    func fetchExerciseInfoWithID() {
        self.viewModel.fetchExerciseInfoWithID(self.exerciseID)
    }
}

// MARK: - Preview

/// A preview of the ExerciseDetailView with a default exercise ID.
struct ExerciseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseDetailView(exerciseID: 0)
    }
}
