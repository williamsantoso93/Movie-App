//
//  MovieScreen.swift
//  Movie-App
//
//  Created by William Santoso on 15/09/23.
//

import SwiftUI

struct MovieScreen: View {
    @State private var movies: [Movie] = []
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(movies.indices, id: \.self) { index in
                        NavigationLink {
                            MovieDetailScreen(movie: $movies[index])
                        } label: {
                            MovieRowView(movie: movies[index])
                        }
                    }
                }
                .padding(16)
            }
            .navigationTitle("Movie")
            .refreshable {
                Task {
//                    await viewModel.fetchNewList()
                }
            }
            .task {
                do {
                    let movies = try await Fetcher.getNowPlayingMovieList()
                    Task { @MainActor in
                        self.movies = movies.results
                    }
                } catch {
                    
                }
            }
        }
    }
}

struct MovieScreen_Previews: PreviewProvider {
    static var previews: some View {
        TabView {
            MovieScreen()
        }
    }
}
