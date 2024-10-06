//
//  DeepLinkManager.swift
//  Places
//
//  Created by Ilayda Kodal on 05/10/2024.
//

import SwiftUI

final class DeepLinkManager: DeepLinkManaging {

    // MARK: - Properties
    private let baseDeepLinkURL = "wikipedia://places?"
    static let shared = DeepLinkManager()

    func openDeepLink(for location: LocationDTO) {
        guard let deepLinkURL = makeDeepLinkURL(for: location) else {
            print("⚠️ Invalid deep link URL")
            return
        }

        UIApplication.shared.open(deepLinkURL, options: [:]) { success in
            if success {
                print("🌐 Successfully opened deep link to \(location.name ?? "")")
            } else {
                print("⚠️ Failed to open deep link")
            }
        }
    }

    func handleDeepLink(url: URL) {
        guard url.scheme == "wikipedia", url.host == "places" else {
            print("⚠️ Invalid deep link URL")
            return
        }

        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        var latitude: Double?
        var longitude: Double?
        var name: String?

        components?.queryItems?.forEach { item in
            switch item.name {
            case "latitude":
                latitude = Double(item.value ?? "")
            case "longitude":
                longitude = Double(item.value ?? "")
            case "name":
                name = item.value
            default:
                break
            }
        }

        print("🌐 Received deep link: Latitude: \(latitude ?? 0), Longitude: \(longitude ?? 0), Name: \(name ?? "Unknown")")
    }
}

// MARK: - Private
extension DeepLinkManager {
    private func makeDeepLinkURL(for location: LocationDTO) -> URL? {
        var urlComponents = URLComponents(string: baseDeepLinkURL)
        urlComponents?.queryItems = [
            URLQueryItem(name: "latitude", value: String(location.lat)),
            URLQueryItem(name: "longitude", value: String(location.long))
        ]

        if let encodedLocationName = location.name?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), !encodedLocationName.isEmpty {
            urlComponents?.queryItems?.append(URLQueryItem(name: "name", value: encodedLocationName))
        }

        return urlComponents?.url
    }
}
