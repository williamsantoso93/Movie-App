//
//  FavoritesScreen.swift
//  Movie-App
//
//  Created by William Santoso on 16/09/23.
//

import SwiftUI

struct FavoritesScreen: View {
    @StateObject private var viewModel: FavoritesViewModel = FavoritesViewModel()
    
    var body: some View {
        NavigationStack {
            MovieListView(movies: .constant(viewModel.displayedMovies))
                .overlay {
                    if !viewModel.search.isEmpty && viewModel.displayedMovies.isEmpty {
                        Text("There is no \"\(viewModel.search)\"")
                    } else if viewModel.displayedMovies.isEmpty {
                        Text("No Favorite Movie")
                    }
                }
                .searchable(text: $viewModel.search)
                .navigationTitle("Favorites")
                .onAppear {
                    viewModel.fetchMovies()
                }
                .onSubmit(of: .search) {
                    viewModel.fetchMovies()
                }
                .refreshable {
                    viewModel.fetchMovies()
                }
        }
    }
}

struct FavoritesScreen_Previews: PreviewProvider {
    static var previews: some View {
        TabView {
            FavoritesScreen()
        }
    }
}
