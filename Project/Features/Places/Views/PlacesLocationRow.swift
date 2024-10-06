//
//  PlacesLocationRow.swift
//  Places
//
//  Created by Ilayda Kodal on 05/10/2024.
//

import SwiftUI

struct LocationRow: View {
    let location: LocationDTO

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(location.name ?? "")
                    .font(.headline)
                Text("Latitude: \(location.lat), Longitude: \(location.long)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
    }
}
