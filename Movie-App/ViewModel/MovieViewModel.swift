//
//  MovieViewModel.swift
//  Movie-App
//
//  Created by William Santoso on 16/09/23.
//

import Foundation

class MovieViewModel: BaseViewModel {
    @Published var movie: Movie
    @Published var isSaved: Bool = false
    
    init(movie: Movie) {
        self.movie = movie
        
        super.init()
        
        isSaved = fetchSaveStatus()
    }
    
    func fetchSaveStatus() -> Bool {
        false
    }
    
    func fetchImages() async {
        guard movie.image == nil else { return }
        
        loading(true)
        do {
            let movieImages = try await Fetcher.getMovieImages(id: movie.id)
            
            Task { @MainActor in
                movie.image = movieImages
            }
        } catch {
            print(error.localizedDescription)
        }
        loading(false)
    }
    
    func save() -> Bool {
        //TODO: add function
        false
    }
}
