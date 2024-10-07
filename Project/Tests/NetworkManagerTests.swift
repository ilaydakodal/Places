//
//  NetworkManagerTests.swift
//  PlacesTests
//
//  Created by Ilayda Kodal on 06/10/2024.
//

import XCTest
@testable import Places

final class NetworkManagerTests: XCTestCase {
    var networkManager: NetworkManaging!
    var mockSession: MockURLSession!

    override func setUp() {
        super.setUp()
        mockSession = MockURLSession()
        networkManager = NetworkManager(urlSession: mockSession)
    }

    override func tearDown() {
        networkManager = nil
        mockSession = nil
        super.tearDown()
    }

    func testFetch_Success() async throws {
        // Given
        let expectedData = LocationsDTO(locations: [LocationDTO(name: "Place", lat: 52.0, long: 4.0)])
        let jsonData = try JSONEncoder().encode(expectedData)

        mockSession.data = jsonData
        mockSession.response = HTTPURLResponse(url: URL(string: "http://example.com")!,
                                               statusCode: 200,
                                               httpVersion: nil,
                                               headerFields: nil)

        // When
        let result: LocationsDTO = try await networkManager.fetch(from: Endpoints.locations)

        // Then
        XCTAssertEqual(result.locations.first?.name, expectedData.locations.first?.name)
    }

    func testFetch_InvalidResponse() async {
        // Given
        mockSession.response = URLResponse()

        do {
            // When
            let _: LocationsDTO = try await networkManager.fetch(from: Endpoints.locations)
            XCTFail("Expected to throw an error but didn't.")
        } catch {
            // Then
            XCTAssertEqual(error as? NetworkError, NetworkError.invalidResponse)
        }
    }

    func testFetch_InvalidURL() async {
        // Given
        let endpoint = MockInvalidURLEndpoint()

        do {
            // When
            let _: LocationsDTO = try await networkManager.fetch(from: endpoint)
            XCTFail("Expected to throw an error but didn't.")
        } catch {
            // Then
            XCTAssertEqual(error as? NetworkError, NetworkError.invalidURL)
        }
    }

    func testFetch_DecodingError() async {
        // Given
        mockSession.data = "Invalid Data".data(using: .utf8)
        mockSession.response = HTTPURLResponse(url: URL(string: "http://example.com")!,
                                               statusCode: 200,
                                               httpVersion: nil,
                                               headerFields: nil)

        do {
            // When
            let _: LocationsDTO = try await networkManager.fetch(from: Endpoints.locations)
            XCTFail("Expected to throw an error but didn't.")
        } catch {
            // Then
            XCTAssertTrue(error is NetworkError)
            if case NetworkError.decodingError = error {
            } else {
                XCTFail("Expected a decoding error.")
            }
        }
    }

    func testFetch_InvalidResponseStatusCode() async {
        // Given
        mockSession.response = HTTPURLResponse(url: URL(string: "http://example.com")!,
                                               statusCode: 404,
                                               httpVersion: nil,
                                               headerFields: nil)

        do {
            // When
            let _: LocationsDTO = try await networkManager.fetch(from: Endpoints.locations)
            XCTFail("Expected to throw an error but didn't.")
        } catch {
            // Then
            XCTAssertEqual(error as? NetworkError, NetworkError.invalidResponse)
        }
    }
}
