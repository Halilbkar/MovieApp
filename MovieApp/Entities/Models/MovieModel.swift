//
//  MovieModel.swift
//  MovieApp
//
//  Created by Halil Bakar on 27.08.2023.
//

import Foundation

struct MovieModel: Codable {
    let results: [MovieInfo]
}

struct MovieInfo: Codable {
    let id: Int
    let media_type: String
    let original_name: String
    let original_title: String
    let poster_path: String
    let overview: String
    let vote_count: Int
    let release_date: String
    let vote_average: Double
}
