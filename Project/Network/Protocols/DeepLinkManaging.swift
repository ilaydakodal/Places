//
//  DeepLinkManaging.swift
//  Places
//
//  Created by Ilayda Kodal on 06/10/2024.
//

import Foundation

protocol DeepLinkManaging {
    func openDeepLink(for location: LocationDTO)
    func handleDeepLink(url: URL)
}
