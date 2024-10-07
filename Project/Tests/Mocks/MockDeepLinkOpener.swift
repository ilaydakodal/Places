//
//  MockDeepLinkOpener.swift
//  Places
//
//  Created by Ilayda Kodal on 07/10/2024.
//

import UIKit
@testable import Places

final class MockDeepLinkOpener: DeepLinkOpener {
    var isOpenCalled = false
    var success: Bool = true
    var lastOpenedLocation: LocationDTO?

    func open(_ url: URL, options: [UIApplication.OpenURLOptionsKey : Any], completionHandler: ((Bool) -> Void)?) {
        isOpenCalled = true
        completionHandler?(success)
    }
}

extension MockDeepLinkOpener: DeepLinkManaging {
    func openDeepLink(for location: Places.LocationDTO) {
        isOpenCalled = true
        lastOpenedLocation = location
    }

    func handleDeepLink(url: URL) {}
}
