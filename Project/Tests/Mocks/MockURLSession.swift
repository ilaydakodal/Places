//
//  MockURLSession.swift
//  Places
//
//  Created by Ilayda Kodal on 07/10/2024.
//

import Foundation
@testable import Places

final class MockURLSession: URLSessionProtocol {
    var data: Data?
    var response: URLResponse?
    var error: Error?

    func data(from url: URL) async throws -> (Data, URLResponse) {
        if let error = error {
            throw error
        }
        return (data ?? Data(), response ?? URLResponse())
    }
}
