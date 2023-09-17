//
//  NetworkingTest.swift
//  Movie-AppTests
//
//  Created by William Santoso on 15/09/23.
//

import XCTest
@testable import Movie_App

final class NetworkingTest: XCTestCase {
    let fetcher = Fetcher()
    
    //MARK: - Movie List
    func test_NowPlayingMovieList_ShouldGetMovieListSucceccfully() async throws {
        let data = try await fetcher.getNowPlayingMovieList()
        XCTAssertTrue(!data.results.isEmpty)
    }
    
    func test_PopularMovieList_ShouldGetMovieListSucceccfully() async throws {
        let data = try await fetcher.getPopularMovieList()
        
        XCTAssertTrue(!data.results.isEmpty)
    }
    
    func test_TopRatedMovieList_ShouldGetMovieListSucceccfully() async throws {
        let data = try await fetcher.getTopRatedMovieList()
        
        XCTAssertTrue(!data.results.isEmpty)
    }
    
    func test_UpcomingMovieList_ShouldGetMovieListSucceccfully() async throws {
        let data = try await fetcher.getUpcomingMovieList()
        
        XCTAssertTrue(!data.results.isEmpty)
    }
    
    func test_MovieDetail_GivenCorrectMovieId_ShouldGetMovieDetailSucceccfully() async throws {
        let movieId = 123
        let data = try await fetcher.getMovieDetail(id: movieId)
        
        XCTAssertEqual(movieId, data.id)
    }
    
    func test_MovieDetail_GivenIncorrectMovieId_ShouldGetError() async throws {
        do {
            let data = try await fetcher.getMovieDetail(id: 0)
            XCTAssertNil(data)
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    func test_MovieImages_GivenCorrectMovieId_ShouldGetMovieImagesSucceccfully() async throws {
        let movieId = 615656
        let data = try await fetcher.getMovieImages(id: movieId)
        print(data)
        
        XCTAssertEqual(movieId, data.id)
    }
    
    func test_MovieImages_GivenIncorrectMovieId_ShouldGetError() async throws {
        do {
            let data = try await fetcher.getMovieImages(id: 0)
            XCTAssertNil(data)
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    func test_MovieSearch_GivenCorrectQuery_ShouldGetMovieListSucceccfully() async throws {
        let keyword = "meg 2"
        let data = try await fetcher.searchMovies(by: keyword)
        
        XCTAssertTrue(data.results.contains(where: { movie in
            (movie.title ?? "").lowercased().contains(keyword)
        }))
    }
    
    func test_MovieSearch_GivenIncorrectQuery_ShouldMovieListBeEmpty() async throws {
        let data = try await fetcher.searchMovies(by: "!@#$%^&*")
        
        XCTAssertTrue(data.results.isEmpty)
    }
}
