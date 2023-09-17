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
    @Published private var viewContext = PersistenceController.shared.container.viewContext
    
    @Published var movies: [Movie] = []
    @Published var search: String = ""
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    //TODO: load data from local storage
    func fetchMovies() async {
    }
}

class ItemViewModel: ObservableObject {
    @Published private var coreDataManager = CoreDataManager.shared
    
    private var viewContext: NSManagedObjectContext {
        coreDataManager.viewContext
    }
    
    @Published var items: [Item] = []
    @Published var movies: [MovieItem] = []
    
    init() {
        fetch()
    }
    
    func fetch() {
        let request = NSFetchRequest<Item>(entityName: "Item")
        
        do {
            items = try viewContext.fetch(request)
        }catch {
            print("DEBUG: Some error occured while fetching")
        }
        
    }
    func fetchMovie() {
        let request = NSFetchRequest<MovieItem>(entityName: "MovieItem")
        
        do {
            movies = try viewContext.fetch(request)
        }catch {
            print("DEBUG: Some error occured while fetching")
        }
        
    }
    
    func addMovieItem() {
        withAnimation {
            let newItem = MovieItem(context: viewContext)
            
            newItem.id = Int64(Movie.fakeMovie().id)
            newItem.data = Movie.fakeMovie().toString()
            
            coreDataManager.save()
            fetchMovie()
        }
    }
    
    func deleteMovieItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { movies[$0] }.forEach(viewContext.delete)
            
            coreDataManager.save()
            fetch()
        }
    }
    
    func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            
            coreDataManager.save()
            fetch()
        }
    }
    
    func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            coreDataManager.save()
            fetch()
        }
    }
}
