//
//  Movie.swift
//  Movie-App
//
//  Created by William Santoso on 15/09/23.
//

import Foundation

// MARK: - MovieList
struct MovieList: Codable {
    var page: Int
    var results: [Movie]
    var totalPages, totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Movie
struct Movie: Codable, Identifiable {
    var id: Int
    var adult: Bool
    var backdropPath: String
    var backdropImageUrl: String {
        "\(Fetcher.imageBaseUrl)/w780\(backdropPath)"
    }
    var originalLanguage: String
    var originalTitle, overview: String
    var popularity: Double
    var posterPath, releaseDate, title: String
    var posterImageUrl: String {
        "\(Fetcher.imageBaseUrl)/w342\(posterPath)"
    }
    var video: Bool
    var voteAverage: Double
    var voteCount: Int
    var image: MovieImages? = nil
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - backdrops
struct MovieImages: Codable {
    var backdrops: [MovieImageBackdrop]
    var id: Int
    var logos, posters: [MovieImagePoster]
}

// MARK: - MovieImage
struct MovieImageBackdrop: Codable, Hashable {
    var aspectRatio: Double
    var height: Int
    var iso639_1: String?
    var filePath: String
    var imageUrl: String {
        "\(Fetcher.imageBaseUrl)/w780\(filePath)"
    }
    var voteAverage: Double
    var voteCount, width: Int
    
    enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case height
        case iso639_1 = "iso_639_1"
        case filePath = "file_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case width
    }
}
struct MovieImagePoster: Codable, Hashable {
    var aspectRatio: Double
    var height: Int
    var iso639_1: String?
    var filePath: String
    var imageUrl: String {
        "\(Fetcher.imageBaseUrl)/w342\(filePath)"
    }
    var voteAverage: Double
    var voteCount, width: Int
    
    enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case height
        case iso639_1 = "iso_639_1"
        case filePath = "file_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case width
    }
}
