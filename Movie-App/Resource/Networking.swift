//
//  Networking.swift
//  Movie-App
//
//  Created by William Santoso on 15/09/23.
//

import Foundation

enum RequestError: Error {
    case decode
    case invalidURL
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case unknown
}

class Networking {
    static let token = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0Mzk0MjQ1YTcyYjc5ZWQ4ZWEyNTY4YWIwOWQ4OGFjNiIsInN1YiI6IjY1MDQ1YTQwZGI0ZWQ2MTAzM2EzZGUxMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Na-QOKyEWkM01mJ5K1WC7Zv9fGMRXt5T7lzmo0UpjXw"
    
    static func sendRequest<T: Decodable>(url: String, parameters: [String: String]? = nil) async -> Result<T, RequestError> {
        var urlComponents = URLComponents(string: url)
        
        if let parameters = parameters,
           !parameters.isEmpty {
            var queryItems = [URLQueryItem]()
            for (key, value) in parameters {
                queryItems.append(URLQueryItem(name: key, value: "\(value)"))
            }
            urlComponents?.queryItems = queryItems
        }
        
        guard let url = urlComponents?.url else {
            return .failure(.invalidURL)
        }
        
        print("Endpoint : ", url )
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }
            print("Response :\n", String(data: data, encoding: .utf8) ?? "")
            switch response.statusCode {
            case 200...299:
                do {
                    let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                    return .success(decodedResponse)
                } catch {
                    print(error)
                    return .failure(.decode)
                }
            case 401:
                return .failure(.unauthorized)
            default:
                return .failure(.unexpectedStatusCode)
            }
        } catch {
            return .failure(.unknown)
        }
    }
}

class Fetcher {
    static let baseUrl: String = "https://api.themoviedb.org/3"
    static var imageBaseUrl: String = "https://image.tmdb.org/t/p/"
    
    static func getNowPlayingMovieList(page: Int = 1) async throws -> MovieList {
        let url = "\(baseUrl)/movie/now_playing"
        let params: [String: String] = [
            "page": "\(page)",
        ]
        
        let result: Result<MovieList, RequestError> = await Networking.sendRequest(url: url, parameters: params)
        switch result {
        case .success(let data):
            return data
        case .failure(let error):
            throw error
        }
    }
    
    static func getPopularMovieList(page: Int = 1) async throws -> MovieList {
        let url = "\(baseUrl)/movie/popular"
        let params: [String: String] = [
            "page": "\(page)",
        ]
        
        let result: Result<MovieList, RequestError> = await Networking.sendRequest(url: url, parameters: params)
        switch result {
        case .success(let data):
            return data
        case .failure(let error):
            throw error
        }
    }
    
    static func getTopRatedMovieList(page: Int = 1) async throws -> MovieList {
        let url = "\(baseUrl)/movie/top_rated"
        let params: [String: String] = [
            "page": "\(page)",
        ]
        
        let result: Result<MovieList, RequestError> = await Networking.sendRequest(url: url, parameters: params)
        switch result {
        case .success(let data):
            return data
        case .failure(let error):
            throw error
        }
    }
    
    static func getUpcomingMovieList(page: Int = 1) async throws -> MovieList {
        let url = "\(baseUrl)/movie/upcoming"
        let params: [String: String] = [
            "page": "\(page)",
        ]
        
        let result: Result<MovieList, RequestError> = await Networking.sendRequest(url: url, parameters: params)
        switch result {
        case .success(let data):
            return data
        case .failure(let error):
            throw error
        }
    }
    
    static func getMovieDetail(id: Int) async throws -> Movie {
        let url = "\(baseUrl)/movie/\(id)"
        
        let result: Result<Movie, RequestError> = await Networking.sendRequest(url: url)
        switch result {
        case .success(let data):
            return data
        case .failure(let error):
            throw error
        }
    }
    
    static func getMovieImages(id: Int) async throws -> MovieImages {
        let url = "\(baseUrl)/movie/\(id)/images"
        let params: [String: String] = [
            "include_image_language": "en",
            "language": "en",
        ]
        
        let result: Result<MovieImages, RequestError> = await Networking.sendRequest(url: url, parameters: params)
        switch result {
        case .success(let data):
            return data
        case .failure(let error):
            throw error
        }
    }
}
