//
//  MovieListViewModel.swift
//  Movie-App
//
//  Created by William Santoso on 16/09/23.
//

import Foundation

class MovieListViewModel: BaseViewModel {
    @Published var movies: [Movie] = []
    @Published var type: MovieListType = .nowPlaying
    
    var page: Int = 1
    var totalPage: Int = 1
    
    func fetchMovies(isNext: Bool = false) async {
        if isNext && page < totalPage {
            page += 1
        } else {
            page = 1
            Task { @MainActor in
                movies.removeAll()
            }
        }
        
        loading(true)
        do {
            let list: MovieList
            
            switch type {
            case .nowPlaying:
                list = try await fetcher.getNowPlayingMovieList(page: page)
            case .popular:
                list = try await fetcher.getPopularMovieList(page: page)
            case .topRated:
                list = try await fetcher.getTopRatedMovieList(page: page)
            case .upcoming:
                list = try await fetcher.getUpcomingMovieList(page: page)
            }
            
            Task { @MainActor in
                movies += list.results
                totalPage = list.totalPages
            }
        } catch {
            print(error.localizedDescription)
        }
        loading(false)
    }
}
