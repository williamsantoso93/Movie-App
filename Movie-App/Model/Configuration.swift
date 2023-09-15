//
//  Configuration.swift
//  Movie-App
//
//  Created by William Santoso on 15/09/23.
//

import Foundation

// MARK: - Configuration
struct Configuration: Codable {
    var images: Images
    var changeKeys: [String]
    
    enum CodingKeys: String, CodingKey {
        case images
        case changeKeys = "change_keys"
    }
}

// MARK: - Images
struct Images: Codable {
    var baseURL: String
    var secureBaseURL: String
    var backdropSizes, logoSizes, posterSizes, profileSizes: [String]
    var stillSizes: [String]
    
    enum CodingKeys: String, CodingKey {
        case baseURL = "base_url"
        case secureBaseURL = "secure_base_url"
        case backdropSizes = "backdrop_sizes"
        case logoSizes = "logo_sizes"
        case posterSizes = "poster_sizes"
        case profileSizes = "profile_sizes"
        case stillSizes = "still_sizes"
    }
}
