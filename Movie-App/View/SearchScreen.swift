//
//  SearchScreen.swift
//  Movie-App
//
//  Created by William Santoso on 16/09/23.
//

import SwiftUI

struct SearchScreen: View {
    @StateObject private var viewModel: SearchViewModel = SearchViewModel()
    
    var body: some View {
        NavigationStack {
            MovieListView(movies: $viewModel.movies) {
                Task {
                    await viewModel.fetchMovies(isNext: true)
                }
            }
            .overlay {
                if viewModel.search.isEmpty && viewModel.movies.isEmpty {
                    Text("Please Input search")
                } else if !viewModel.search.isEmpty && viewModel.movies.isEmpty {
                    Text("There is no \"\(viewModel.search)\"")
                }
            }
            .navigationTitle("Search")
            .searchable(text: $viewModel.search)
            .onSubmit(of: .search) {
                Task {
                    await viewModel.fetchMovies()
                }
            }
            .refreshable {
                Task {
                    await viewModel.fetchMovies()
                }
            }
            .task {
                guard !viewModel.search.isEmpty && !viewModel.movies.isEmpty else { return }
                
                await viewModel.fetchMovies()
            }
        }
    }
}

struct SearchScreen_Previews: PreviewProvider {
    static var previews: some View {
        TabView {
            SearchScreen()
        }
    }
}
