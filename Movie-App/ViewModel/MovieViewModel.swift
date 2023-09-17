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
    
    private var moviesItem: [MovieItem] = []
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func fetchSaveStatus() {
        let request = NSFetchRequest<MovieItem>(entityName: "MovieItem")
        
        guard
            let moviesItem = try? viewContext.fetch(request)
        else {
            isSaved = false
            return
        }
        
        self.moviesItem = moviesItem
        
        isSaved = moviesItem.contains(where: { item in
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
            isSaved = true
            
            return true
        } catch {
            print(error.localizedDescription)
            isSaved = false
            return false
        }
    }
    
    func delete() -> Bool {
        guard let movieItem = moviesItem.first(where: { movieItem in
            Int(movieItem.id) == movie.id
        }) else { return false }
        
        viewContext.delete(movieItem)
        coreDataManager.save()
        
        fetchSaveStatus()
        
        return true
    }
    
    //func deleteMovieItems(offsets: IndexSet) {
    //    withAnimation {
    //        offsets.map { movies[$0] }.forEach(viewContext.delete)
    //
    //        coreDataManager.save()
    //        fetch()
    //    }
    //    }
}
