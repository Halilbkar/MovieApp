//
//  MoviesEndPoint.swift
//  MovieApp
//
//  Created by Halil Bakar on 27.08.2023.
//

import Foundation

enum MoviesEndpoint: EndpointProtocol {
    
    case trending
    case popular
    case topRated
    case discover
    case upComing
    case trailer
    
    var baseURL: URL {
        guard let movieUrl = URL(string: "https://api.themoviedb.org/3") else {
            fatalError("url failed")
        }
        
        guard let trailerUrl = URL(string: "https://api.themoviedb.org/3") else {
            fatalError("url failed")
        }
        
        switch self {
        case .trending, .popular, .topRated, .discover, .upComing:
            return movieUrl
        case .trailer:
            return trailerUrl
        }
    }
    
    var path: String {
        switch self {
        case .trending:
            return "/trending/movie/day"
        case .popular:
            return "/movie/popular"
        case .topRated:
            return "/movie/top_rated"
        case .discover:
            return "/discover/movie"
        case .upComing:
            return "/movie/upcoming"
        case .trailer:
            return "/movie/upcoming"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .trending, .popular, .topRated, .discover, .upComing, .trailer:
            return .get
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .trending, .popular, .topRated, .discover, .upComing:
            return ["api_key": "f81dc68d4ad164dd20d18f0b531204b6"]
        case .trailer:
            return ["api_key": "f81dc68d4ad164dd20d18f0b531204b6"]
        }
    }
}
