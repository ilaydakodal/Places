//
//  NetworkManaging.swift
//  Places
//
//  Created by Ilayda Kodal on 06/10/2024.
//

protocol NetworkManaging {
    func fetch<T: Decodable>(from endpoint: Endpoints) async throws -> T
}
