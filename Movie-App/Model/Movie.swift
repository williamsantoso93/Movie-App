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
        let movieImages = MovieImages(backdrops: Optional([MovieImage(filePath: Optional("/8pjWz2lt29KyVGoq1mXYu6Br7dE.jpg")), MovieImage(filePath: Optional("/2iNUodSKykQ4VtvtG280ntNy7hB.jpg")), MovieImage(filePath: Optional("/nmei2VyCb7RYWPgH9ayvwMGXYww.jpg")), MovieImage(filePath: Optional("/pYFNA112h90QtMDN5MGouTioL8M.jpg")), MovieImage(filePath: Optional("/5qAFgeWIuSb1VrZlGdSuHb5xe2T.jpg")), MovieImage(filePath: Optional("/wMHPWMjR4UcGDU054NIhP74lbHt.jpg")), MovieImage(filePath: Optional("/oEJl2d0OdI9uURU3maAQHqj7P1h.jpg")), MovieImage(filePath: Optional("/1QDFJNTNBNNDNHaiLiVI2APO2py.jpg")), MovieImage(filePath: Optional("/tw67OlJ4tesaAw8R9i0Dq196KM3.jpg"))]), id: 615656, logos: Optional([MovieImage(filePath: Optional("/xjzbSDGtnxnr2E1eXWTEcmVbuZR.png")), MovieImage(filePath: Optional("/xfu52018OAqF3J6Oc7HQBYbOot6.png")), MovieImage(filePath: Optional("/wpv8lP3C5WEqov4niCwUInx8Crw.png")), MovieImage(filePath: Optional("/pmG7DR97uoEUSSimCp7QKkwlaUM.png"))]), posters: Optional([MovieImage(filePath: Optional("/4m1Au3YkjqsxF8iwQy0fPYSxE0h.jpg")), MovieImage(filePath: Optional("/FQHtuf2zc8suMFE28RyvFt3FJN.jpg")), MovieImage(filePath: Optional("/drCySAAAvegq1vQRGRqPKN9f00w.jpg")), MovieImage(filePath: Optional("/uvYbo4eF3q6W06kpx5iDwC4jt6N.jpg")), MovieImage(filePath: Optional("/nJPlTkgnWUWTzGfDm3DH0yWZoM5.jpg")), MovieImage(filePath: Optional("/iNweHQSpBqiV4oTueFUGzhBqzO9.jpg")), MovieImage(filePath: Optional("/b3pYeNq5URt7IADL9xlOadyMv73.jpg")), MovieImage(filePath: Optional("/mkMRoepr0sNMksQBlc4HSbye7fR.jpg")), MovieImage(filePath: Optional("/kGMe8oqY2m8tWRFp3jjglmL7jnY.jpg")), MovieImage(filePath: Optional("/3VEBy0YOa9LRfTXJTedltsc2CrY.jpg")), MovieImage(filePath: Optional("/jhknTb0IgkNO5iXGAjOqU5aZ4Vq.jpg")), MovieImage(filePath: Optional("/4iMP9bYlsleqP5zhffi8eu1AI2w.jpg")), MovieImage(filePath: Optional("/gn1NYCe3LBGFaeWJv2uFlUSFrdZ.jpg")), MovieImage(filePath: Optional("/yIRyyC7EXqOHAJjM29wAIbH1nQY.jpg")), MovieImage(filePath: Optional("/6K7P4RtBZmNKkituNdDuarFMh9R.jpg")), MovieImage(filePath: Optional("/AkTPs7pjonA2CPUcWNfWeQQ5mO9.jpg")), MovieImage(filePath: Optional("/b4nrJALNRBbhOVKnEpjEl8t2DGG.jpg")), MovieImage(filePath: Optional("/cft9sAu8HMqDd6zCnjXkypLFyCB.jpg")), MovieImage(filePath: Optional("/hImi8ZPWU1WCZ3IyPA6E9hP6rQp.jpg")), MovieImage(filePath: Optional("/58qcnS8anwKGO3EivX0ibwrDIg2.jpg")), MovieImage(filePath: Optional("/qmOzB9kbWuBNdwlaXRklI3MJNs6.jpg")), MovieImage(filePath: Optional("/yphyMQn6KEUa4LoCYIuYZjv2M3O.jpg")), MovieImage(filePath: Optional("/zDZcHcKOv1RVfmjVAgRHPv4bmkJ.jpg")), MovieImage(filePath: Optional("/7ZtGxAzYsEZZTUSfRtdDA4JCdi6.jpg")), MovieImage(filePath: Optional("/kFKkSUutiKaOWxo9fC2f6YkytDi.jpg")), MovieImage(filePath: Optional("/6h3LZcgIyFgyLd7N2MDQhKIqDKZ.jpg")), MovieImage(filePath: Optional("/nd2iDzOYXiITdAgG6w7x9WQ6nWG.jpg")), MovieImage(filePath: Optional("/dARsjcAJfqtXP37iOPUS6b3XgP3.jpg")), MovieImage(filePath: Optional("/seHvZ6MgkmuVgwYywIGL1OnUjsU.jpg"))]))
        
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
    var backdrops: [MovieImage]?
    var id: Int
    var logos, posters: [MovieImage]?
}

// MARK: - MovieImage
struct MovieImage: Codable, Hashable {
    var filePath: String?
    var imageUrl: String? {
        guard let filePath = filePath else { return nil }
        return "\(Fetcher.imageBaseUrl)/w780\(filePath)"
    }
    
    enum CodingKeys: String, CodingKey {
        case filePath = "file_path"
    }
}
