//
//  NetworkError.swift
//  Places
//
//  Created by Ilayda Kodal on 05/10/2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError(Error)
}
