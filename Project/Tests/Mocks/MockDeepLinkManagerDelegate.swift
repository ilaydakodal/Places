//
//  MockDeepLinkManagerDelegate.swift
//  Places
//
//  Created by Ilayda Kodal on 07/10/2024.
//

@testable import Places

final class MockDeepLinkManagerDelegate: DeepLinkManagerDelegate {
    var latitude: Double?
    var longitude: Double?
    var name: String?

    func didReceiveLocationDetails(latitude: Double?, longitude: Double?, name: String?) {
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
    }
}
