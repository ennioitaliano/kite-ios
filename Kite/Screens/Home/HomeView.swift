//
//  HomeView.swift
//  Kite
//
//  Created by Ennio Italiano on 03/10/24.
//

import CoreLocation
import CoreLocationUI
import Dependencies
import SwiftUI

struct HomeView: View {
    @State private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    if let AQI = viewModel.airPollution?.list.first?.AQI {
                        AirQualityTileView(AQI: AQI)
                            .environment(viewModel)
                    }
                    PollutantsGridView(pollutants: viewModel.airPollution?.list.first?.components ?? [:])
                }
                .padding(.horizontal)
            }
            .background(Color.black.brightness(0.25).ignoresSafeArea())
            .navigationTitle("Kite")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    refreshButton
                }
                //                ToolbarItem(placement: .topBarLeading) {
                //                    Button("Experiments", systemImage: "flask") {
                //
                //                    }
                //                    .tint(.white)
                //                }
            }
        }
        .task {
            await viewModel.getAirPollution(
                for: .init(
                    latitude: .init(45.4642),
                    longitude: .init(11.1900)
                )
            )
        }
    }
    
    @ViewBuilder
    private var refreshButton: some View {
        if viewModel.isDataLoading {
            ProgressView()
        } else {
            Button("Refresh", systemImage: "arrow.trianglehead.clockwise") {
                Task {
                    await viewModel.getAirPollution(
                        for: .init(
                            latitude: .init(45.4642),
                            longitude: .init(11.1900)
                        )
                    )
                }
            }
            .tint(.white)
        }
    }
}

#Preview {
    HomeView()
}
