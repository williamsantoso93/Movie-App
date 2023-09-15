//
//  NetworkingTest.swift
//  Movie-AppTests
//
//  Created by William Santoso on 15/09/23.
//

import XCTest
@testable import Movie_App

final class NetworkingTest: XCTestCase {
    //MARK: - Movie List
    func test_NowPlayingMovieList_ShouldGetMovieListSucceccfully() async throws {
        let data = try await Fetcher.getNowPlayingMovieList()
        XCTAssertTrue(!data.results.isEmpty)
    }
    
    func test_PopuparMovieList_ShouldGetMovieListSucceccfully() async throws {
        let data = try await Fetcher.getPopularMovieList()
        
        XCTAssertTrue(!data.results.isEmpty)
    }
    
    func test_TopRatedMovieList_ShouldGetMovieListSucceccfully() async throws {
        let data = try await Fetcher.getTopRatedMovieList()
        
        XCTAssertTrue(!data.results.isEmpty)
    }
    
    func test_UpcomingMovieList_ShouldGetMovieListSucceccfully() async throws {
        let data = try await Fetcher.getUpcomingMovieList()
        
        XCTAssertTrue(!data.results.isEmpty)
    }
    
    
    func test_MovieDetail_GivenCorrectMovieId_ShouldGetMovieDetailSucceccfully() async throws {
        let movieId = 123
        let data = try await Fetcher.getMovieDetail(id: movieId)
        
        XCTAssertEqual(movieId, data.id)
    }
    
    func test_MovieDetail_GivenIncorrectMovieId_ShouldGetError() async throws {
        do {
            let data = try await Fetcher.getMovieDetail(id: 0)
            XCTAssertNil(data)
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    func test_MovieImages_GivenCorrectMovieId_ShouldGetMovieImagesSucceccfully() async throws {
        let movieId = 615656
        let data = try await Fetcher.getMovieImages(id: movieId)
        print(data)
        
        XCTAssertEqual(movieId, data.id)
    }
    
    func test_MovieImages_GivenIncorrectMovieId_ShouldGetError() async throws {
        do {
            let data = try await Fetcher.getMovieImages(id: 0)
            XCTAssertNil(data)
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
