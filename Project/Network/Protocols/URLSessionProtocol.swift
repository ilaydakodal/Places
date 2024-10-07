//
//  URLSessionProtocol.swift
//  Places
//
//  Created by Ilayda Kodal on 07/10/2024.
//

import Foundation

protocol URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}
