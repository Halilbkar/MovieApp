//
//  MoviesEndPoint.swift
//  MovieApp
//
//  Created by Halil Bakar on 27.08.2023.
//

import Foundation

enum MoviesEndpoint: EndpointProtocol, CaseIterable {
    
    case trending
    case popular
    case topRated
    case discover
    case upComing
    
    var baseURL: URL {
        guard let url = URL(string: "https://api.themoviedb.org/3") else {
            fatalError("url failed")
        }
        return url
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
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .trending, .popular, .topRated, .discover, .upComing:
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
        }
    }
}
