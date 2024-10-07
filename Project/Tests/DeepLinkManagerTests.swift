//
//  DeepLinkManagerTests.swift
//  PlacesTests
//
//  Created by Ilayda Kodal on 07/10/2024.
//

import XCTest
import SwiftUI
@testable import Places

final class DeepLinkManagerTests: XCTestCase {
    var deepLinkManager: DeepLinkManager!
    var mockDelegate: MockDeepLinkManagerDelegate!
    var mockOpener: MockDeepLinkOpener!

    override func setUp() {
        super.setUp()
        deepLinkManager = DeepLinkManager.shared
        mockDelegate = MockDeepLinkManagerDelegate()
        mockOpener = MockDeepLinkOpener()
        deepLinkManager.urlOpener = mockOpener
        deepLinkManager.delegate = mockDelegate
    }

    override func tearDown() {
        deepLinkManager = nil
        mockDelegate = nil
        mockOpener = nil
        super.tearDown()
    }

    func testOpenDeepLink_ValidLocation() {
        // Given
        let location = LocationDTO(name: "Test Place", lat: 52.0, long: 4.0)

        // When
        deepLinkManager.openDeepLink(for: location)

        // Then
        XCTAssertTrue(mockOpener.isOpenCalled, "The open method should be called on the deep link opener")
    }

    func testHandleDeepLink_ValidURL() {
        // Given
        let url = URL(string: "wikipedia://places?latitude=52.0&longitude=4.0&name=Test%20Place")!

        // When
        deepLinkManager.handleDeepLink(url: url)

        // Then
        XCTAssertEqual(mockDelegate.latitude, 52.0, "Latitude should be correct")
        XCTAssertEqual(mockDelegate.longitude, 4.0, "Longitude should be correct")
        XCTAssertEqual(mockDelegate.name, "Test Place", "Name should be correct")
    }

    func testHandleDeepLink_InvalidURL() {
        // Given
        let url = URL(string: "invalid://link")!

        // When
        deepLinkManager.handleDeepLink(url: url)

        // Then
        XCTAssertNil(mockDelegate.latitude, "Latitude should be nil for invalid URL")
        XCTAssertNil(mockDelegate.longitude, "Longitude should be nil for invalid URL")
        XCTAssertNil(mockDelegate.name, "Name should be nil for invalid URL")
    }

    func testHandleDeepLink_ValidURLMissingQueryItems() {
        // Given
        let url = URL(string: "wikipedia://places?latitude=52.0")!

        // When
        deepLinkManager.handleDeepLink(url: url)

        // Then
        XCTAssertEqual(mockDelegate.latitude, 52.0, "Latitude should be correct")
        XCTAssertNil(mockDelegate.longitude, "Longitude should be nil for missing query items")
        XCTAssertNil(mockDelegate.name, "Name should be nil for missing query items")
    }
}
