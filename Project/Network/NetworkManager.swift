//
//  NetworkManager.swift
//  Places
//
//  Created by Ilayda Kodal on 05/10/2024.
//

import Foundation

final class NetworkManager: NetworkManaging {

    // MARK: Properties
    private let urlSession: URLSessionProtocol
    static let shared = NetworkManager()

    // MARK: - Init
    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }

    // MARK: - Fetch Data
    func fetch<T: Decodable>(from endpoint: EndpointProtocol) async throws -> T {
        let url = try makeURL(from: endpoint)
        print("🌍 Fetching data from URL: \(url)")

        let (data, response) = try await fetchData(from: url)

        guard (200...299).contains((response as? HTTPURLResponse)?.statusCode ?? 0) else {
            print("🚨 Invalid response status code")
            throw NetworkError.invalidResponse
        }

        return try decode(data)
    }
}

// MARK: - Helpers
extension NetworkManager {
    private func makeURL(from endpoint: EndpointProtocol) throws -> URL {
        guard let url = endpoint.url() else {
            print("❌ Invalid URL")
            throw NetworkError.invalidURL
        }
        return url
    }

    private func fetchData(from url: URL) async throws -> (Data, URLResponse) {
        let (data, response) = try await urlSession.data(from: url)
        guard response is HTTPURLResponse else {
            print("🚨 Invalid response type")
            throw NetworkError.invalidResponse
        }
        return (data, response)
    }

    private func decode<T: Decodable>(_ data: Data) throws -> T {
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            print("✅ Successfully decoded data: \(decodedData)")
            return decodedData
        } catch {
            print("⚠️ Error decoding data: \(error.localizedDescription)")
            throw NetworkError.decodingError(error)
        }
    }
}
