//
//  EndPointProtocol.swift
//  MovieApp
//
//  Created by Halil Bakar on 25.08.2023.
//

import Foundation

protocol EndpointProtocol {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var headers: [String : String]? { get }
    var parameters: [String : Any]? { get }
}

extension EndpointProtocol {
    func urlRequest() -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        
        if let headers = headers {
            headers.forEach { key, value in
                urlRequest.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let parameters = parameters {
            switch httpMethod {
            case .get:
                if var components = URLComponents(url: url, resolvingAgainstBaseURL: false) {
                    components.queryItems = parameters.map { key, value in
                        URLQueryItem(name: key, value: "\(value)")
                    }
                    urlRequest.url = components.url
                }
            case .post, .put, .delete, .patch:
                let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
                urlRequest.httpBody = jsonData
            }
        }
        
        return urlRequest
    }
}
