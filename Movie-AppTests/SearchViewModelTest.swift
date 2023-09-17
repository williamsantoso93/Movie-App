//
//  SearchViewModelTest.swift
//  Movie-AppTests
//
//  Created by William Santoso on 17/09/23.
//

import XCTest
@testable import Movie_App

class SearchViewModelTest: XCTestCase {
    var viewModel: SearchViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = SearchViewModel()
        viewModel.fetcher = MockFetcher()
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }
    
    func test_fetchMovies_initialPage_shouldUpdateMovies() {
        let exp = expectation(description: "Loading Movies")
        
        viewModel.search = "YourSearchQuery"
        
        Task {
            await viewModel.fetchMovies()
            
            Task { @MainActor in
                XCTAssertGreaterThan(viewModel.movies.count, 0)
                exp.fulfill()
            }
        }
        
        waitForExpectations(timeout: 3)
    }
    
    func test_fetchMovies_nextPage_shouldAppendMovies() {
        let exp = expectation(description: "Loading Next Page of Movies")
        
        viewModel.search = "YourSearchQuery"
        
        Task {
            await viewModel.fetchMovies()
            let initialCount = viewModel.movies.count
            
            await viewModel.fetchMovies(isNext: true)
            
            Task { @MainActor in
                XCTAssertGreaterThan(viewModel.movies.count, initialCount)
                exp.fulfill()
            }
        }
        
        waitForExpectations(timeout: 3)
    }
    
    func test_fetchMovies_withError_shouldNotUpdateMovies() {
        let exp = expectation(description: "Loading Movies with Error")
        
        viewModel.search = "InvalidSearchQuery"
        
        Task {
            await viewModel.fetchMovies()
            
            Task { @MainActor in
                XCTAssertEqual(viewModel.movies.count, 0) 
                exp.fulfill()
            }
        }
        
        waitForExpectations(timeout: 3)
    }
}
