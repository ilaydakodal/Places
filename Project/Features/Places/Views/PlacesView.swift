//
//  PlacesView.swift
//  Places
//
//  Created by Ilayda Kodal on 05/10/2024.
//

import SwiftUI

struct PlacesView: View {
    @StateObject var viewModel: PlacesViewModel
    private var deepLinkManager: DeepLinkManaging

    init(viewModel: PlacesViewModel,
         deepLinkManager: DeepLinkManaging = DeepLinkManager()) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self.deepLinkManager = deepLinkManager
    }

    var body: some View {
        NavigationView {
            List(viewModel.locations, id: \.name) { location in
                LocationRow(location: location)
                    .onTapGesture {
                        viewModel.openLocationDeepLink(location: location)
                    }
            }
            .navigationTitle("Places")
            .accessibilityAddTraits(.isHeader)
            .onAppear {
                Task {
                    await viewModel.fetchLocations()
                }
            }
            .overlay {
                if viewModel.isLoading {
                    ProgressView()
                }
            }
        }
        .onOpenURL { url in
            deepLinkManager.handleDeepLink(url: url)
        }
    }
}

#Preview {
    PlacesView(viewModel: PlacesViewModel())
}
