//
//  MovieViewModel.swift
//  Movie-App
//
//  Created by William Santoso on 16/09/23.
//

import Foundation
import CoreData

class MovieViewModel: BaseViewModel {
    @Published private var coreDataManager = CoreDataManager.shared
    
    private var viewContext: NSManagedObjectContext {
        coreDataManager.viewContext
    }
    
    @Published var movie: Movie
    @Published var isSaved: Bool = false
    
    init(movie: Movie) {
        self.movie = movie
        
        super.init()
        
        isSaved = fetchSaveStatus()
    }
    
    func fetchSaveStatus() -> Bool {
        let request = NSFetchRequest<MovieItem>(entityName: "MovieItem")
        
        guard
            let moviesItem = try? viewContext.fetch(request)
        else {
            return false
        }
        
        return moviesItem.contains(where: { item in
            Int(item.id) == movie.id
        })
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
        let newItem = MovieItem(context: viewContext)
        
        newItem.id = Int64(movie.id)
        newItem.data = movie.toString()
        
        guard viewContext.hasChanges else { return false }
        
        do {
            try viewContext.save()
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
}
