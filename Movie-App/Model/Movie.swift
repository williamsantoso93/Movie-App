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
    var backdropPath: String?
    var backdropImageUrl: String? {
        guard let backdropPath = backdropPath else { return nil }
        return "\(Fetcher.imageBaseUrl)/w780\(backdropPath)"
    }
    var originalLanguage: String?
    var originalTitle, overview: String?
    var popularity: Double?
    var posterPath, releaseDate, title: String?
    var posterImageUrl: String? {
        guard let posterPath = posterPath else { return nil }
        return "\(Fetcher.imageBaseUrl)/w342\(posterPath)"
    }
    var video: Bool?
    var voteAverage: Double?
    var voteCount: Int?
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

extension Movie {
    static func fakeMovie() -> Movie {
        let movieImages = MovieImages(backdrops: Optional([MovieImageBackdrop(filePath: Optional("/8pjWz2lt29KyVGoq1mXYu6Br7dE.jpg")), MovieImageBackdrop(filePath: Optional("/2iNUodSKykQ4VtvtG280ntNy7hB.jpg")), MovieImageBackdrop(filePath: Optional("/nmei2VyCb7RYWPgH9ayvwMGXYww.jpg")), MovieImageBackdrop(filePath: Optional("/pYFNA112h90QtMDN5MGouTioL8M.jpg")), MovieImageBackdrop(filePath: Optional("/5qAFgeWIuSb1VrZlGdSuHb5xe2T.jpg")), MovieImageBackdrop(filePath: Optional("/wMHPWMjR4UcGDU054NIhP74lbHt.jpg")), MovieImageBackdrop(filePath: Optional("/oEJl2d0OdI9uURU3maAQHqj7P1h.jpg")), MovieImageBackdrop(filePath: Optional("/1QDFJNTNBNNDNHaiLiVI2APO2py.jpg")), MovieImageBackdrop(filePath: Optional("/tw67OlJ4tesaAw8R9i0Dq196KM3.jpg"))]), id: 615656, logos: Optional([MovieImagePoster(aspectRatio: 3.237, height: 1297, iso639_1: Optional("en"), filePath: "/xjzbSDGtnxnr2E1eXWTEcmVbuZR.png", voteAverage: 5.384, voteCount: 2, width: 4198), MovieImagePoster(aspectRatio: 3.237, height: 1297, iso639_1: Optional("en"), filePath: "/xfu52018OAqF3J6Oc7HQBYbOot6.png", voteAverage: 5.384, voteCount: 2, width: 4198), MovieImagePoster(aspectRatio: 3.233, height: 993, iso639_1: Optional("en"), filePath: "/wpv8lP3C5WEqov4niCwUInx8Crw.png", voteAverage: 5.246, voteCount: 2, width: 3210), MovieImagePoster(aspectRatio: 1.66, height: 482, iso639_1: Optional("en"), filePath: "/pmG7DR97uoEUSSimCp7QKkwlaUM.png", voteAverage: 5.106, voteCount: 2, width: 800)]), posters: Optional([MovieImagePoster(aspectRatio: 0.667, height: 3000, iso639_1: Optional("en"), filePath: "/4m1Au3YkjqsxF8iwQy0fPYSxE0h.jpg", voteAverage: 5.576, voteCount: 13, width: 2000), MovieImagePoster(aspectRatio: 0.667, height: 3000, iso639_1: Optional("en"), filePath: "/FQHtuf2zc8suMFE28RyvFt3FJN.jpg", voteAverage: 5.518, voteCount: 12, width: 2000), MovieImagePoster(aspectRatio: 0.667, height: 3000, iso639_1: Optional("en"), filePath: "/drCySAAAvegq1vQRGRqPKN9f00w.jpg", voteAverage: 5.388, voteCount: 4, width: 2000), MovieImagePoster(aspectRatio: 0.667, height: 3000, iso639_1: Optional("en"), filePath: "/uvYbo4eF3q6W06kpx5iDwC4jt6N.jpg", voteAverage: 5.264, voteCount: 8, width: 2000), MovieImagePoster(aspectRatio: 0.667, height: 3000, iso639_1: Optional("en"), filePath: "/nJPlTkgnWUWTzGfDm3DH0yWZoM5.jpg", voteAverage: 5.258, voteCount: 6, width: 2000), MovieImagePoster(aspectRatio: 0.667, height: 3000, iso639_1: Optional("en"), filePath: "/iNweHQSpBqiV4oTueFUGzhBqzO9.jpg", voteAverage: 5.252, voteCount: 4, width: 2000), MovieImagePoster(aspectRatio: 0.667, height: 1500, iso639_1: Optional("en"), filePath: "/b3pYeNq5URt7IADL9xlOadyMv73.jpg", voteAverage: 5.246, voteCount: 2, width: 1000), MovieImagePoster(aspectRatio: 0.667, height: 3000, iso639_1: Optional("en"), filePath: "/mkMRoepr0sNMksQBlc4HSbye7fR.jpg", voteAverage: 5.18, voteCount: 3, width: 2000), MovieImagePoster(aspectRatio: 0.675, height: 1481, iso639_1: Optional("en"), filePath: "/kGMe8oqY2m8tWRFp3jjglmL7jnY.jpg", voteAverage: 5.18, voteCount: 3, width: 1000), MovieImagePoster(aspectRatio: 0.664, height: 1507, iso639_1: Optional("en"), filePath: "/3VEBy0YOa9LRfTXJTedltsc2CrY.jpg", voteAverage: 5.172, voteCount: 1, width: 1000), MovieImagePoster(aspectRatio: 0.666, height: 1229, iso639_1: Optional("en"), filePath: "/jhknTb0IgkNO5iXGAjOqU5aZ4Vq.jpg", voteAverage: 5.172, voteCount: 1, width: 819), MovieImagePoster(aspectRatio: 0.667, height: 3000, iso639_1: Optional("en"), filePath: "/4iMP9bYlsleqP5zhffi8eu1AI2w.jpg", voteAverage: 5.172, voteCount: 1, width: 2000), MovieImagePoster(aspectRatio: 0.667, height: 1425, iso639_1: Optional("en"), filePath: "/gn1NYCe3LBGFaeWJv2uFlUSFrdZ.jpg", voteAverage: 5.172, voteCount: 1, width: 950), MovieImagePoster(aspectRatio: 0.667, height: 1425, iso639_1: Optional("en"), filePath: "/yIRyyC7EXqOHAJjM29wAIbH1nQY.jpg", voteAverage: 5.172, voteCount: 1, width: 950), MovieImagePoster(aspectRatio: 0.667, height: 3000, iso639_1: Optional("en"), filePath: "/6K7P4RtBZmNKkituNdDuarFMh9R.jpg", voteAverage: 5.172, voteCount: 1, width: 2000), MovieImagePoster(aspectRatio: 0.658, height: 3000, iso639_1: Optional("en"), filePath: "/AkTPs7pjonA2CPUcWNfWeQQ5mO9.jpg", voteAverage: 5.172, voteCount: 1, width: 1973), MovieImagePoster(aspectRatio: 0.667, height: 3000, iso639_1: Optional("en"), filePath: "/b4nrJALNRBbhOVKnEpjEl8t2DGG.jpg", voteAverage: 5.128, voteCount: 6, width: 2000), MovieImagePoster(aspectRatio: 0.665, height: 907, iso639_1: Optional("en"), filePath: "/cft9sAu8HMqDd6zCnjXkypLFyCB.jpg", voteAverage: 5.128, voteCount: 6, width: 603), MovieImagePoster(aspectRatio: 0.667, height: 2048, iso639_1: Optional("en"), filePath: "/hImi8ZPWU1WCZ3IyPA6E9hP6rQp.jpg", voteAverage: 5.118, voteCount: 4, width: 1365), MovieImagePoster(aspectRatio: 0.667, height: 2048, iso639_1: Optional("en"), filePath: "/58qcnS8anwKGO3EivX0ibwrDIg2.jpg", voteAverage: 5.106, voteCount: 2, width: 1366), MovieImagePoster(aspectRatio: 0.667, height: 750, iso639_1: Optional("en"), filePath: "/qmOzB9kbWuBNdwlaXRklI3MJNs6.jpg", voteAverage: 5.106, voteCount: 2, width: 500), MovieImagePoster(aspectRatio: 0.667, height: 3000, iso639_1: Optional("en"), filePath: "/yphyMQn6KEUa4LoCYIuYZjv2M3O.jpg", voteAverage: 0.0, voteCount: 0, width: 2000), MovieImagePoster(aspectRatio: 0.679, height: 1236, iso639_1: Optional("en"), filePath: "/zDZcHcKOv1RVfmjVAgRHPv4bmkJ.jpg", voteAverage: 0.0, voteCount: 0, width: 839), MovieImagePoster(aspectRatio: 0.679, height: 1236, iso639_1: Optional("en"), filePath: "/7ZtGxAzYsEZZTUSfRtdDA4JCdi6.jpg", voteAverage: 0.0, voteCount: 0, width: 839), MovieImagePoster(aspectRatio: 0.679, height: 1236, iso639_1: Optional("en"), filePath: "/kFKkSUutiKaOWxo9fC2f6YkytDi.jpg", voteAverage: 0.0, voteCount: 0, width: 839), MovieImagePoster(aspectRatio: 0.667, height: 750, iso639_1: Optional("en"), filePath: "/6h3LZcgIyFgyLd7N2MDQhKIqDKZ.jpg", voteAverage: 0.0, voteCount: 0, width: 500), MovieImagePoster(aspectRatio: 0.667, height: 750, iso639_1: Optional("en"), filePath: "/nd2iDzOYXiITdAgG6w7x9WQ6nWG.jpg", voteAverage: 0.0, voteCount: 0, width: 500), MovieImagePoster(aspectRatio: 0.667, height: 750, iso639_1: Optional("en"), filePath: "/dARsjcAJfqtXP37iOPUS6b3XgP3.jpg", voteAverage: 0.0, voteCount: 0, width: 500), MovieImagePoster(aspectRatio: 0.667, height: 1500, iso639_1: Optional("en"), filePath: "/seHvZ6MgkmuVgwYywIGL1OnUjsU.jpg", voteAverage: 0.0, voteCount: 0, width: 1000)]))
        
        let movie = Movie(id: 615656, adult: false, backdropPath: "/8pjWz2lt29KyVGoq1mXYu6Br7dE.jpg", originalLanguage: "en", originalTitle: "Meg 2: The Trench", overview: "An exploratory dive into the deepest depths of the ocean of a daring research team spirals into chaos when a malevolent mining operation threatens their mission and forces them into a high-stakes battle for survival.", popularity: 2237.141, posterPath: "/4m1Au3YkjqsxF8iwQy0fPYSxE0h.jpg", releaseDate: "2023-08-02", title: "Meg 2: The Trench", video: false, voteAverage: 7.0, voteCount: 1701, image: movieImages)
        
        return movie

    }
    func toString() -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        guard
            let jsonData = try? encoder.encode(self),
            let jsonString = String(data: jsonData, encoding: .utf8)
        else {
            return nil
        }
        return jsonString
    }
    
    static func decode(_ data: String?) -> Movie? {
        guard
            let data = data,
            let jsonData = data.data(using: .utf8),
            let movie = try? JSONDecoder().decode(Movie.self, from: jsonData)
        else {
            return nil
        }
        
        return movie
    }
}

// MARK: - backdrops
struct MovieImages: Codable {
    var backdrops: [MovieImageBackdrop]?
    var id: Int
    var logos, posters: [MovieImagePoster]?
}

// MARK: - MovieImage
struct MovieImageBackdrop: Codable, Hashable {
    var filePath: String?
    var imageUrl: String? {
        guard let filePath = filePath else { return nil }
        return "\(Fetcher.imageBaseUrl)/w780\(filePath)"
    }
    
    enum CodingKeys: String, CodingKey {
        case filePath = "file_path"
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
