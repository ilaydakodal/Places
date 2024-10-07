//
//  MockInvalidURLEndpoint.swift
//  Places
//
//  Created by Ilayda Kodal on 07/10/2024.
//

import Foundation
@testable import Places

struct MockInvalidURLEndpoint: EndpointProtocol {
    var baseURL: URL {
        return BaseURL.url
    }

    var path: String {
        return "invalid_path"
    }

    func url() -> URL? {
        return nil
    }
}
