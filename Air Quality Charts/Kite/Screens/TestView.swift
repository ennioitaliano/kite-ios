//
//  TestView.swift
//  Kite
//
//  Created by Ennio Italiano on 03/10/24.
//

import CoreLocation
import Dependencies
import SwiftUI

struct TestView: View {
    @Dependency(\.airPollutionRemoteRepository) private var APRemoteRepository
    @Dependency(\.geocodingRemoteRepository) private var GCRemoteRepository

    var body: some View {
        VStack {
            Button("AP Current") {
                Task {
                    try print(
                        await APRemoteRepository.getCurrent(
                            for: CLLocationCoordinate2D(
                                latitude: 50,
                                longitude: 50
                            )
                        )
                    )
                }
            }
            Button("AP Forecast") {
                Task {
                    try print(
                        await APRemoteRepository.getForecast(
                            for: CLLocationCoordinate2D(
                                latitude: 50,
                                longitude: 50
                            )
                        )
                    )
                }
            }
            Button("AP Historical") {
                Task {
                    try print(
                        await APRemoteRepository.getHistorical(
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
            Button("GC Coords Location") {
                Task {
                    try print(
                        await GCRemoteRepository.getCoordinates(
                            location: "Padua,IT",
                            limit: 1
                        )
                    )
                }
            }
            Button("GC Coords Zip") {
                Task {
                    try print(
                        await GCRemoteRepository.getCoordinates(
                            zipCode: "35037,IT"
                        )
                    )
                }
            }
            Button("GC Reverse") {
                Task {
                    try print(
                        await GCRemoteRepository.getLocation(
                            for: .init(
                                latitude: 50,
                                longitude: 50
                            ),
                            limit: 5
                        )
                    )
                }
            }
        }
        .padding()
    }
}

#Preview {
    TestView()
}
