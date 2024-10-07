//
//  EndpointProtocol.swift
//  Places
//
//  Created by Ilayda Kodal on 06/10/2024.
//

import Foundation

protocol EndpointProtocol {
    var baseURL: URL { get }
    var path: String { get }

    func url() -> URL?
}
