//
//  MockNetworkManager.swift
//  PlacesTests
//
//  Created by Ilayda Kodal on 07/10/2024.
//

import Foundation
@testable import Places

final class MockNetworkManager: NetworkManaging {
    var shouldReturnError = false
    var locationsToReturn: [LocationDTO] = []

    func fetch<T: Decodable>(from endpoint: EndpointProtocol) async throws -> T {
        if shouldReturnError {
            throw NSError(domain: "TestError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Test Error"])
        }

        if T.self == LocationsDTO.self {
            return LocationsDTO(locations: locationsToReturn) as! T
        }

        throw NSError(domain: "MockError", code: 2, userInfo: [NSLocalizedDescriptionKey: "Unexpected type"])
    }
}
