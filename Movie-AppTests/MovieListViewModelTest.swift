//
//  MovieListViewModelTest.swift
//  Movie-AppTests
//
//  Created by William Santoso on 17/09/23.
//

import XCTest
@testable import Movie_App

final class MovieListViewModelTest: XCTestCase {
    var viewModel: MovieListViewModel!
    
    override func setUpWithError() throws {
        viewModel = MovieListViewModel()
        viewModel.fetcher = MockFetcher()
    }
    
    override func tearDownWithError() throws {
        super.tearDown()
        viewModel = nil
    }
    
    func test_fetchMovies_forNowPlaying_shouldUpdateMovies() {
        let exp = expectation(description: "Loading Movies")
        
        viewModel.type = .nowPlaying
        
        Task {
            await viewModel.fetchMovies()
            
            try await Task.sleep(nanoseconds: 1_000_000_000)
            
            Task { @MainActor in
                sleep(1)
                XCTAssertEqual(viewModel.movies.count, 2)
                
                exp.fulfill()
            }
        }
        
        waitForExpectations(timeout: 3)
    }
    
    func test_fetchMovies_forPopular_shouldUpdateMovies() {
        let exp = expectation(description: "Loading Movies")
        
        viewModel.type = .popular
        
        Task {
            await viewModel.fetchMovies()
            
            try await Task.sleep(nanoseconds: 1_000_000_000)
            
            Task { @MainActor in
                sleep(1)
                XCTAssertEqual(viewModel.movies.count, 2)
                
                exp.fulfill()
            }
        }
        
        waitForExpectations(timeout: 3)
    }
    
    func test_fetchMovies_forTopRated_shouldUpdateMovies() {
        let exp = expectation(description: "Loading Movies")
        
        viewModel.type = .topRated
        
        Task {
            await viewModel.fetchMovies()
            
            try await Task.sleep(nanoseconds: 1_000_000_000)
            
            Task { @MainActor in
                sleep(1)
                XCTAssertEqual(viewModel.movies.count, 2)
                
                exp.fulfill()
            }
        }
        
        waitForExpectations(timeout: 3)
    }
    
    func test_fetchMovies_forUpcoming_shouldUpdateMovies() {
        let exp = expectation(description: "Loading Movies")
        
        viewModel.type = .upcoming
        
        Task {
            await viewModel.fetchMovies()
            
            try await Task.sleep(nanoseconds: 1_000_000_000)
            
            Task { @MainActor in
                sleep(1)
                XCTAssertEqual(viewModel.movies.count, 2)
                
                exp.fulfill()
            }
        }
        
        waitForExpectations(timeout: 3)
    }
}
