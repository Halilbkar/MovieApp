//
//  NetworkError.swift
//  MovieApp
//
//  Created by Halil Bakar on 25.08.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidURLRequest
    case requestFailed
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL.", comment: "")
        case .invalidResponse:
            return NSLocalizedString("Invalid response.", comment: "")
        case .requestFailed:
            return NSLocalizedString("Request failed.", comment: "")
        case .invalidURLRequest:
            return NSLocalizedString("Invalid URL Request.", comment: "")
        }
    }
}
