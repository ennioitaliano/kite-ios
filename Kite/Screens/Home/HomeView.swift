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
    @State private var viewModel: HomeViewModel = .init()
    @State private var showSearchAlert: Bool = false
    @State private var locationText: String = "Teolo"
    @State private var displayedLocation: String?

    private func getAirPollution() async {
        let geocoder = CLGeocoder()
        let placemark = try? await geocoder.geocodeAddressString(locationText).first
        if let placemark {
            displayedLocation = if let locality = placemark.locality, let country = placemark.country {
                "\(locality), \(country)"
            } else {
                locationText
            }
            await viewModel.getAirPollution(for: placemark)
        }
    }

    var body: some View {
        NavigationStack {
            KiteList {
                aqiInfo
                pollutantsList
            }
            .background(Color.black.brightness(0.25).ignoresSafeArea())
            .refreshable {
                await getAirPollution()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    searchLocationButton
                }
            }
        }
        .preferredColorScheme(.dark)
        .alert("Change location", isPresented: $showSearchAlert) {
            TextField(text: $locationText) {}
            Button("Submit") {
                Task {
                    await getAirPollution()
                }
            }
            Button("Cancel", role: .cancel) {}
        }
        .task {
            await getAirPollution()
        }
    }

    @ViewBuilder
    private var searchLocationButton: some View {
        if let displayedLocation {
            Button {
                showSearchAlert = true
                locationText = displayedLocation
            } label: {
                Label(displayedLocation, systemImage: "magnifyingglass")
                    .font(.system(size: 14))
                    .foregroundStyle(.white)
                    .labelStyle(.titleAndIcon)
            }
        }
    }

    @ViewBuilder
    private var aqiInfo: some View {
            AirQualityTileView()
                .environment(viewModel)
                .padding(.bottom, 32)
    }

    @ViewBuilder
    private var pollutantsList: some View {
        if let pollutants = viewModel.pollutantsList?.sorted(by: { $0.value > $1.value }) {
            ForEach(pollutants, id: \.key) { pollutant in
                PollutantRowView(
                    pollutant: pollutant.key,
                    quantity: pollutant.value.convert(
                        to: pollutant.key.measureUnit,
                        with: pollutant.key.molecularWeight
                    )
                )
                .padding(.bottom, 12)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    HomeView()
}
