//
//  MovieScreen.swift
//  Movie-App
//
//  Created by William Santoso on 15/09/23.
//

import SwiftUI

enum MovieListType: String, CaseIterable {
    case nowPlaying = "Now Playing"
    case popular = "Popular"
    case topRated = "Top Rated"
    case upcoming = "Upcoming"
}

struct MovieScreen: View {
    @StateObject private var viewModel: MovieListViewModel = MovieListViewModel()
    
    var body: some View {
        NavigationStack {
            Picker("", selection: $viewModel.type) {
                ForEach(MovieListType.allCases, id: \.self) { type in
                    Text(type.rawValue)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            .onChange(of: viewModel.type) { newValue in
                Task {
                    await viewModel.fetchMovies()
                }
            }
            
            MovieListView(movies: $viewModel.movies) {
                Task {
                    await viewModel.fetchMovies(isNext: true)
                }
            }
            .navigationTitle("Movie")
            .refreshable {
                Task {
                    await viewModel.fetchMovies()
                }
            }
            .task {
                guard ProcessInfo.processInfo.environment["isTest"] != "1" && viewModel.movies.isEmpty else { return }
                await viewModel.fetchMovies()
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
