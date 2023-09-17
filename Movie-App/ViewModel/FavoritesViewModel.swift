//
//  FavoritesViewModel.swift
//  Movie-App
//
//  Created by William Santoso on 16/09/23.
//

import Foundation
import SwiftUI
import CoreData

class FavoritesViewModel: BaseViewModel {
    @Published private var coreDataManager = CoreDataManager.shared
    
    private var viewContext: NSManagedObjectContext {
        coreDataManager.viewContext
    }
    
    @Published var movies: [Movie] = []
    
    var displayedMovies: [Movie] {
        guard !search.isEmpty else { return movies }
        
        return movies.filter { movie in
            guard let title = movie.title else { return false }
            print(title,search, title.lowercased().contains(search.lowercased()))
            return (movie.title ?? "").lowercased().contains(search.lowercased())
        }
    }
    @Published var search: String = ""
    
    func fetchMovies() {
        let request = NSFetchRequest<MovieItem>(entityName: "MovieItem")
        
        do {
            let moviesItem = try viewContext.fetch(request)
            var movies: [Movie] = []
            
            for item in moviesItem {
                if let movie = Movie.decode(item.data) {
                    movies.append(movie)
                }
            }
            self.movies = movies
        } catch {
            print(error.localizedDescription)
        }
    }
}
