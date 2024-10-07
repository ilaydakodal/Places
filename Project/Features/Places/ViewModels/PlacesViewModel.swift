//
//  PlacesViewModel.swift
//  Places
//
//  Created by Ilayda Kodal on 05/10/2024.
//

import Foundation

@MainActor
final class PlacesViewModel: ObservableObject {

    // MARK: - Properties
    @Published private(set) var locations: [LocationDTO] = []
    @Published private(set) var errorMessage: String?
    @Published private(set) var isLoading: Bool = false

    private let networkManager: NetworkManaging
    private let deepLinkManager: DeepLinkManaging

    // MARK: - Init
    init(networkManager: NetworkManaging = NetworkManager.shared,
         deepLinkManager: DeepLinkManaging = DeepLinkManager.shared) {
        self.networkManager = networkManager
        self.deepLinkManager = deepLinkManager
    }
}

extension PlacesViewModel {

    func fetchLocations() async {
        isLoading = true
        errorMessage = nil

        do {
            let locationsDTO: LocationsDTO = try await networkManager.fetch(from: Endpoints.locations)
            locations = locationsDTO.locations
        } catch {
            errorMessage = "Failed to fetch locations: \(error.localizedDescription)"
        }

        isLoading = false
    }

    // MARK: - Deep Linking
    func openLocationDeepLink(location: LocationDTO) {
        deepLinkManager.openDeepLink(for: location)
    }
}
