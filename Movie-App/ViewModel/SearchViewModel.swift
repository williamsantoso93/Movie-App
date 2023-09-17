//
//  SearchViewModel.swift
//  Movie-App
//
//  Created by William Santoso on 16/09/23.
//

import Foundation

class SearchViewModel: BaseViewModel {
    @Published var movies: [Movie] = []
    @Published var search: String = ""
    
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
            let list: MovieList = try await fetcher.searchMovies(by: search, page: page)
            
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
