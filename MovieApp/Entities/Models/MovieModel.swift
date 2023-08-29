//
//  MovieModel.swift
//  MovieApp
//
//  Created by Halil Bakar on 27.08.2023.
//

import Foundation

struct MovieModel: Codable {
    let results: [Results]
}

struct Results: Codable {
    let id: Int
    let original_title: String
    let poster_path: String
    let overview: String
    let release_date: String
    let vote_average: Double
}
