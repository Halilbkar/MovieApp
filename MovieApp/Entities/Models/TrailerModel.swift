//
//  TrailerModel.swift
//  MovieApp
//
//  Created by Halil Bakar on 6.09.2023.
//

import Foundation

struct TrailerModel: Codable {
    let items: [TrailerItems]
}

struct TrailerItems: Codable {
    let id: TrailerElements
}

struct TrailerElements: Codable {
    let kind: String
    let videoId: String
}
