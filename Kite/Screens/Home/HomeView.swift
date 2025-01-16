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
            ScrollView {
                PollutantsGridView(pollutants: viewModel.airPollution?.list.first?.components ?? [:])
                    .padding(.horizontal)
                    .navigationTitle("Kite")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button("Refresh", systemImage: "arrow.trianglehead.clockwise") {
                                Task {
                                    await viewModel.getCurrentAirPollution(
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
            .background(Color.black.brightness(0.25).ignoresSafeArea())
        }
        .task {
            await viewModel.getCurrentAirPollution(
                for: .init(
                    latitude: .init(45.4642),
                    longitude: .init(11.1900)
                )
            )
        }
    }
}

#Preview {
    HomeView()
}
