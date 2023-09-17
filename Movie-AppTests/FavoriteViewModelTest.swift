//
//  FavoriteViewModelTest.swift
//  Movie-AppTests
//
//  Created by William Santoso on 17/09/23.
//

import XCTest
import CoreData
@testable import Movie_App

class FavoritesViewModelTests: XCTestCase {
    var viewModel: FavoritesViewModel!
    var coreDataManager: CoreDataManager!
    
    override func setUp() {
        super.setUp()
        coreDataManager = CoreDataManager()
        viewModel = FavoritesViewModel()
        let viewContext = coreDataManager.viewContext
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "MovieItem")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try viewContext.execute(deleteRequest)
            try viewContext.save()
        } catch {
            print("Error deleting data: \(error)")
        }
        
        
        coreDataManager.save()
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
        coreDataManager = nil
    }
    
    private func createMockMovieItem(id: Int,title: String) {
        let movieItem = MovieItem(context: coreDataManager.viewContext)
        movieItem.data = Movie(id: id, adult: false, title: title).toString()
    }
    
    private func isContainsTitle(movies: [Movie], title: String) -> Bool {
        movies.contains { movie in
            (movie.title ?? "").contains(title)
        }
    }
    
    func test_fetchMovies() {
        createMockMovieItem(id: 1, title: "Movie 1")
        createMockMovieItem(id: 2, title: "Movie 2")
        
        coreDataManager.save()
        
        viewModel.fetchMovies()
        
        XCTAssertEqual(viewModel.movies.count, 2)
        XCTAssertTrue(isContainsTitle(movies: viewModel.movies, title: "Movie 1"))
        XCTAssertTrue(isContainsTitle(movies: viewModel.movies, title: "Movie 2"))
    }
    
    func test_searchAndFilterMovies() {
        createMockMovieItem(id: 1, title: "Movie 1")
        createMockMovieItem(id: 2, title: "Movie 2")
        createMockMovieItem(id: 3, title: "Another")
        
        coreDataManager.save()
        
        viewModel.fetchMovies()
        
        viewModel.search = "Movie"
        
        XCTAssertEqual(viewModel.displayedMovies.count, 2)
        XCTAssertTrue(isContainsTitle(movies: viewModel.displayedMovies, title: "Movie 1"))
        XCTAssertTrue(isContainsTitle(movies: viewModel.displayedMovies, title: "Movie 2"))
        
        viewModel.search = "Another"
        
        XCTAssertEqual(viewModel.displayedMovies.count, 1)
        XCTAssertTrue(isContainsTitle(movies: viewModel.displayedMovies, title: "Another"))
    }
}
