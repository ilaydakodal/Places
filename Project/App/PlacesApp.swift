//
//  PlacesApp.swift
//  Places
//
//  Created by Ilayda Kodal on 05/10/2024.
//

import SwiftUI

@main
struct PlacesApp: App {
    @StateObject private var viewModel = PlacesViewModel()

    var body: some Scene {
        WindowGroup {
            PlacesView(viewModel: viewModel)
        }
    }
}
