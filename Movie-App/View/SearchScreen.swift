//
//  SearchScreen.swift
//  Movie-App
//
//  Created by William Santoso on 16/09/23.
//

import SwiftUI

struct SearchScreen: View {
    @StateObject private var viewModel: SearchViewModel = SearchViewModel()
    
    @State private var onSearching: Bool = false
    
    var body: some View {
        NavigationStack {
            MovieListView(movies: $viewModel.movies) {
                Task {
                    await viewModel.fetchMovies(isNext: true)
                }
            }
            .overlay {
                VStack {
                    if !viewModel.search.isEmpty && viewModel.movies.isEmpty && onSearching {
                        Text("There is no \"\(viewModel.search)\"")
                    }
                    
                    if viewModel.movies.isEmpty && !onSearching {
                        Text("Please Input search")
                    }
                }
            }
            .navigationTitle("Search")
            .searchable(text: $viewModel.search)
            .onChange(of: viewModel.search, perform: { newValue in
                if newValue.isEmpty && onSearching {
                    viewModel.movies.removeAll()
                    onSearching = false
                }
            })
            .onSubmit(of: .search) {
                onSearching = true
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

extension Bool {
    func toString() -> String {
        self ? "true":"false"
    }
}
