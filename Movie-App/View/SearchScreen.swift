//
//  SearchScreen.swift
//  Movie-App
//
//  Created by William Santoso on 16/09/23.
//

import SwiftUI

struct SearchScreen: View {
    @State private var movies: [Movie] = []
    
    @State private var search: String = ""
    @State private var page: Int = 1
    
    var body: some View {
        NavigationStack {
            MovieListView(movies: $movies) {
                Task {
                    page += 1
                    await fetchMovies()
                }
            }
            .overlay {
                if search.isEmpty && movies.isEmpty {
                    Text("Please Input search")
                } else if !search.isEmpty && movies.isEmpty {
                    Text("There is no \"\(search)\"")
                }
            }
            .navigationTitle("Search")
            .searchable(text: $search)
            .onSubmit(of: .search) {
                Task {
                    await fetchMovies()
                }
            }
            .refreshable {
                page = 1
                Task {
                    await fetchMovies()
                }
            }
            .task {
                guard !search.isEmpty else { return }
                
                await fetchMovies()
            }
        }
    }
    
    func fetchMovies() async {
        do {
            let list: MovieList = try await Fetcher.searchMovies(by: search, page: page)
            
            Task { @MainActor in
                if page == 1 {
                    movies.removeAll()
                }
                movies += list.results
            }
        } catch {
            
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
