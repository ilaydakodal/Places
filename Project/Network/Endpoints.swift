//
//  Endpoints.swift
//  Places
//
//  Created by Ilayda Kodal on 05/10/2024.
//

import Foundation

enum Endpoints: EndpointProtocol {
    case locations
}

extension Endpoints {
    var baseURL: URL {
        return BaseURL.url
    }

    var path: String {
        switch self {
        case .locations:
            return "/abnamrocoesd/assignment-ios/main/locations.json"
        }
    }

    func url() -> URL? {
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        urlComponents?.path = path
        return urlComponents?.url
    }
}
