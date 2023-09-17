//
//  MockFetcher.swift
//  Movie-AppTests
//
//  Created by William Santoso on 17/09/23.
//

import Foundation
@testable import Movie_App

class MockFetcher: MovieFetcherProtocol {
    func getNowPlayingMovieList(page: Int = 1) async throws -> MovieList {
        let mockMovie1 = Movie(id: 1, adult: false, backdropPath: "/backdrop1.jpg", originalLanguage: "en", originalTitle: "Movie 1", overview: "Overview 1", popularity: 123.45, posterPath: "/poster1.jpg", releaseDate: "2023-01-01", title: "Movie 1", video: false, voteAverage: 7.5, voteCount: 100, image: nil)
        
        let mockMovie2 = Movie(id: 2, adult: false, backdropPath: "/backdrop2.jpg", originalLanguage: "en", originalTitle: "Movie 2", overview: "Overview 2", popularity: 234.56, posterPath: "/poster2.jpg", releaseDate: "2023-02-02", title: "Movie 2", video: false, voteAverage: 8.0, voteCount: 200, image: nil)
        
        let mockMovieList = MovieList(page: 1, results: [mockMovie1, mockMovie2], totalPages: 1, totalResults: 2)
        return mockMovieList
    }
    
    func getPopularMovieList(page: Int = 1) async throws -> MovieList {
        let mockMovie3 = Movie(id: 3, adult: false, backdropPath: "/backdrop3.jpg", originalLanguage: "en", originalTitle: "Movie 3", overview: "Overview 3", popularity: 345.67, posterPath: "/poster3.jpg", releaseDate: "2023-03-03", title: "Movie 3", video: false, voteAverage: 7.2, voteCount: 150, image: nil)
        
        let mockMovie4 = Movie(id: 4, adult: false, backdropPath: "/backdrop4.jpg", originalLanguage: "en", originalTitle: "Movie 4", overview: "Overview 4", popularity: 456.78, posterPath: "/poster4.jpg", releaseDate: "2023-04-04", title: "Movie 4", video: false, voteAverage: 7.8, voteCount: 180, image: nil)
        
        let mockMovieList = MovieList(page: 1, results: [mockMovie3, mockMovie4], totalPages: 1, totalResults: 2)
        return mockMovieList
    }
    
    func getTopRatedMovieList(page: Int = 1) async throws -> MovieList {
        let mockMovie5 = Movie(id: 5, adult: false, backdropPath: "/backdrop5.jpg", originalLanguage: "en", originalTitle: "Movie 5", overview: "Overview 5", popularity: 567.89, posterPath: "/poster5.jpg", releaseDate: "2023-05-05", title: "Movie 5", video: false, voteAverage: 8.5, voteCount: 220, image: nil)
        
        let mockMovie6 = Movie(id: 6, adult: false, backdropPath: "/backdrop6.jpg", originalLanguage: "en", originalTitle: "Movie 6", overview: "Overview 6", popularity: 678.90, posterPath: "/poster6.jpg", releaseDate: "2023-06-06", title: "Movie 6", video: false, voteAverage: 8.2, voteCount: 210, image: nil)
        
        let mockMovieList = MovieList(page: 1, results: [mockMovie5, mockMovie6], totalPages: 1, totalResults: 2)
        return mockMovieList
    }
    
    func getUpcomingMovieList(page: Int = 1) async throws -> MovieList {
        let mockMovie7 = Movie(id: 7, adult: false, backdropPath: "/backdrop7.jpg", originalLanguage: "en", originalTitle: "Movie 7", overview: "Overview 7", popularity: 789.01, posterPath: "/poster7.jpg", releaseDate: "2023-07-07", title: "Movie 7", video: false, voteAverage: 7.9, voteCount: 170, image: nil)
        
        let mockMovie8 = Movie(id: 8, adult: false, backdropPath: "/backdrop8.jpg", originalLanguage: "en", originalTitle: "Movie 8", overview: "Overview 8", popularity: 890.12, posterPath: "/poster8.jpg", releaseDate: "2023-08-08", title: "Movie 8", video: false, voteAverage: 7.7, voteCount: 160, image: nil)
        
        let mockMovieList = MovieList(page: 1, results: [mockMovie7, mockMovie8], totalPages: 1, totalResults: 2)
        return mockMovieList
    }
    
    func getMovieDetail(id: Int) async throws -> Movie {
        let mockMovie = Movie(id: id, adult: false, backdropPath: "/backdrop\(id).jpg", originalLanguage: "en", originalTitle: "Mock Movie", overview: "This is a mock movie.", popularity: 100.0, posterPath: "/poster\(id).jpg", releaseDate: "2023-01-\(id)", title: "Mock Movie \(id)", video: false, voteAverage: 7.0, voteCount: 1000, image: nil)
        return mockMovie
    }
    
    func getMovieImages(id: Int) async throws -> MovieImages {
        let mockMovieImages = MovieImages(
            backdrops: [MovieImage(filePath: "/backdrop1.jpg"), MovieImage(filePath: "/backdrop2.jpg")],
            id: id,
            logos: [MovieImage(filePath: "/logo1.jpg"), MovieImage(filePath: "/logo2.jpg")],
            posters: [MovieImage(filePath: "/poster1.jpg"), MovieImage(filePath: "/poster2.jpg")]
        )
        return mockMovieImages
    }
    
    func searchMovies(by keyword: String, page: Int = 1) async throws -> MovieList {
        // Mock results based on the search keyword and page
        let mockResults: [Movie]
        
        if keyword == "YourSearchQuery" && page == 1 {
            // Mock result for the initial page with a specific search query
            mockResults = [
                Movie(id: 9, adult: false, backdropPath: "/backdrop9.jpg", originalLanguage: "en", originalTitle: "Movie 9", overview: "Overview 9", popularity: 900.09, posterPath: "/poster9.jpg", releaseDate: "2023-09-09", title: "Movie 9", video: false, voteAverage: 9.0, voteCount: 90, image: nil),
                Movie(id: 10, adult: false, backdropPath: "/backdrop10.jpg", originalLanguage: "en", originalTitle: "Movie 10", overview: "Overview 10", popularity: 1000.0, posterPath: "/poster10.jpg", releaseDate: "2023-10-10", title: "Movie 10", video: false, voteAverage: 9.5, voteCount: 80, image: nil)
            ]
        } else if keyword == "YourSearchQuery" && page == 2 {
            mockResults = []
        } else {
            mockResults = []
        }
        
        let mockMovieList = MovieList(page: page, results: mockResults, totalPages: 1, totalResults: mockResults.count)
        return mockMovieList
    }

}
