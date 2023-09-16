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
    @State private var movies: [Movie] = []
    
    @State private var type: MovieListType = .nowPlaying
    @State private var page: Int = 1
    
    var body: some View {
        NavigationStack {
            Picker("", selection: $type) {
                ForEach(MovieListType.allCases, id: \.self) { type in
                    Text(type.rawValue)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            .onChange(of: type) { newValue in
                page = 1
                Task {
                    await fetchMovies()
                }
            }
            
            MovieListView(movies: $movies) {
                page += 1
                Task {
                    await fetchMovies()
                }
            }
            .navigationTitle("Movie")
            .refreshable {
                page = 1
                Task {
                    await fetchMovies()
                }
            }
            .task {
                guard ProcessInfo.processInfo.environment["isTest"] != "1" else { return }
                await fetchMovies()
            }
        }
    }
    
    func fetchMovies() async {
        do {
            let list: MovieList
            
            switch type {
            case .nowPlaying:
                list = try await Fetcher.getNowPlayingMovieList(page: page)
            case .popular:
                list = try await Fetcher.getPopularMovieList(page: page)
            case .topRated:
                list = try await Fetcher.getTopRatedMovieList(page: page)
            case .upcoming:
                list = try await Fetcher.getUpcomingMovieList(page: page)
            }
            
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

struct MovieScreen_Previews: PreviewProvider {
    static var previews: some View {
        TabView {
            MovieScreen()
        }
    }
}
