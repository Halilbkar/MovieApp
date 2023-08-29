//
//  MoviesEntity.swift
//  MovieApp
//
//  Created by Halil Bakar on 29.08.2023.
//

import Foundation

enum MoviesTitle: CaseIterable {
    case trending
    case topRated
    case upComing
    case popular
    case discover
    
    var title: String {
        switch self {
        case .discover:
            return "Discover"
        case .topRated:
            return "Top Rated"
        case .upComing:
            return "Upcoming"
        case .popular:
            return "Popular"
        case .trending:
            return "Trending"
        }
    }    
}
