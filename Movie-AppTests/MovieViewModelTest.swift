//
//  MovieViewModelTest.swift
//  Movie-AppTests
//
//  Created by William Santoso on 17/09/23.
//

import XCTest
import CoreData
@testable import Movie_App

final
class MovieViewModelTests: XCTestCase {
    var coreDataManager: CoreDataManager!
    var viewContext: NSManagedObjectContext!
    
    override func setUpWithError() throws {
        coreDataManager = CoreDataManager()
        viewContext = coreDataManager.viewContext
        
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
    
    override func tearDownWithError() throws {
        super.tearDown()
        coreDataManager = nil
        viewContext = nil
    }
    
    func test_fetchSaveStatus_withValidData_shouldUpdateIsSavedProperty() throws {
        let movieItem = MovieItem(context: viewContext)
        movieItem.id = 123
        movieItem.data = "Test movie data"
        
        coreDataManager.save()
        
        let movie = Movie(id: 123, adult: false, backdropPath: nil, originalLanguage: "en", originalTitle: "Test Movie", overview: "Test Overview", popularity: 7.5, posterPath: nil, releaseDate: "2023-09-17", title: "Test Movie", video: false, voteAverage: 8.0, voteCount: 100, image: nil)
        
        let viewModel = MovieViewModel(movie: movie)
        
        viewModel.fetchSaveStatus()
        
        XCTAssertTrue(viewModel.isSaved)
    }
    
    func test_saveAndDelete_withValidData_shouldUpdateIsSavedProperty() throws {
        let movie = Movie(id: 456, adult: false, backdropPath: nil, originalLanguage: "en", originalTitle: "Test Movie 2", overview: "Test Overview 2", popularity: 7.5, posterPath: nil, releaseDate: "2023-09-18", title: "Test Movie 2", video: false, voteAverage: 8.0, voteCount: 100, image: nil)
        
        let viewModel = MovieViewModel(movie: movie)
        
        XCTAssertTrue(viewModel.save())
        XCTAssertTrue(viewModel.isSaved)
        
        viewModel.fetchSaveStatus()
        
        XCTAssertTrue(viewModel.delete())
        XCTAssertFalse(viewModel.isSaved)
    }
    
    func test_fetchSaveStatus_withInvalidData_shouldNotUpdateIsSavedProperty() throws {
        let movie = Movie(id: 789, adult: false, backdropPath: nil, originalLanguage: "en", originalTitle: "Test Movie 3", overview: "Test Overview 3", popularity: 7.5, posterPath: nil, releaseDate: "2023-09-19", title: "Test Movie 3", video: false, voteAverage: 8.0, voteCount: 100, image: nil)
        
        let viewModel = MovieViewModel(movie: movie)
        
        viewModel.fetchSaveStatus()
        
        XCTAssertFalse(viewModel.isSaved)
    }
}
