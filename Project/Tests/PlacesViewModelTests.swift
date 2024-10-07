//
//  PlacesViewModelTests.swift
//  Places
//
//  Created by Ilayda Kodal on 07/10/2024.
//

import XCTest
import SwiftUI
@testable import Places

final class PlacesViewModelTests: XCTestCase {
    var viewModel: PlacesViewModel!
    var mockNetworkManager: MockNetworkManager!
    var mockDeepLinkManager: MockDeepLinkOpener!

    override func setUp() async throws {
        try await super.setUp()
        mockNetworkManager = MockNetworkManager()
        mockDeepLinkManager = MockDeepLinkOpener()
        viewModel = await PlacesViewModel(networkManager: mockNetworkManager,
                                           deepLinkManager: mockDeepLinkManager)
    }

    override func tearDown() {
        viewModel = nil
        mockNetworkManager = nil
        mockDeepLinkManager = nil
        super.tearDown()
    }

    @MainActor
    func testFetchLocations_Success() async {
        // Given
        let expectedLocations = [LocationDTO(name: "Place 1", lat: 52.0, long: 4.0)]
        mockNetworkManager.locationsToReturn = expectedLocations

        // When
        await viewModel.fetchLocations()

        // Then
        XCTAssertEqual(viewModel.locations, expectedLocations, "Locations should match the expected locations.")
        XCTAssertNil(viewModel.errorMessage, "Error message should be nil on success.")
        XCTAssertFalse(viewModel.isLoading, "Loading should be false after fetching.")
    }

    @MainActor
    func testFetchLocations_Failure() async {
        // Given
        mockNetworkManager.shouldReturnError = true

        // When
        await viewModel.fetchLocations()

        // Then
        XCTAssertTrue(viewModel.errorMessage?.contains("Failed to fetch locations") == true, "Error message should indicate failure.")
        XCTAssertFalse(viewModel.isLoading, "Loading should be false after failure.")
    }

    @MainActor
    func testOpenLocationDeepLink() {
        // Given
        let location = LocationDTO(name: "Place 1", lat: 52.0, long: 4.0)

        // When
        viewModel.openLocationDeepLink(location: location)

        // Then
        XCTAssertTrue(mockDeepLinkManager.isOpenCalled, "The deep link manager should have been called to open a deep link.")
        XCTAssertEqual(mockDeepLinkManager.lastOpenedLocation, location, "The opened location should match the expected location.")
    }
}
