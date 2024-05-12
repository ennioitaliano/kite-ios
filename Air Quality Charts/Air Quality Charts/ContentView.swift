//
//  ContentView.swift
//  Air Quality Charts
//
//  Created by Ennio Italiano on 09/05/24.
//

import Dependencies
import SwiftUI
import CoreLocation

struct ContentView: View {
    @Dependency(\.airPollutionRemoteRepository) private var APRemoteRepository

    var body: some View {
        VStack {
            Button("Current") {
                Task {
                    print(
                        try await APRemoteRepository.getCurrent(
                            for: CLLocationCoordinate2D(
                                latitude: 50,
                                longitude: 50
                            )
                        )
                    )
                }
            }
            Button("Forecast") {
                Task {
                    print(
                        try await APRemoteRepository.getForecast(
                            for: CLLocationCoordinate2D(
                                latitude: 50,
                                longitude: 50
                            )
                        )
                    )
                }
            }
            Button("Historical") {
                Task {
                    print (
                        try await APRemoteRepository.getHistorical(
                            for: CLLocationCoordinate2D(
                                latitude: 50,
                                longitude: 50
                            ),
                            start: .now,
                            end: .now
                        )
                    )
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
