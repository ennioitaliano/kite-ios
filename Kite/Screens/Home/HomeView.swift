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
    @State private var locationText: String = "Venice"
    @State private var displayedLocation: String?
    @State private var selectedPollutant: Pollutant?

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
            ScrollView {
                VStack(spacing: 32) {
                    aqiInfo
                    pollutantsList
                }
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
            .sheet(item: $selectedPollutant) { pollutant in
                PollutantDetailView(
                    pollutant,
                    quantity: viewModel.pollutantsList?[pollutant]?.convert(
                        to: pollutant.measureUnit,
                        with: pollutant.molecularWeight
                    ) ?? 0
                )
                .presentationDetents([.medium])
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
            Button(displayedLocation, systemImage: "magnifyingglass") {
                showSearchAlert = true
                locationText = displayedLocation
            }
            .labelStyle(.titleAndIcon)
            .font(.system(size: 14))
            .conditionalModifier { view in
                if #available(iOS 26, *) {
                    view.buttonStyle(.glass)
                } else {
                    view
                        .buttonStyle(.bordered)
                        .foregroundStyle(.white)
                }
            }
        }
    }

    @ViewBuilder
    private var aqiInfo: some View {
        if let aqi = viewModel.airQualityIndex,
           let comparisonSentence = viewModel.comparisonSentence {
            AirQualityTileView(
                airQualityIndex: aqi,
                comparisonSentence: comparisonSentence
            )
        }
    }

    @ViewBuilder
    private var pollutantsList: some View {
        if let pollutants = viewModel.pollutantsList?.sorted(by: { $0.value > $1.value }) {
            LazyVStack(spacing: 12) {
                ForEach(pollutants, id: \.key) { pollutant in
                    Button {
                        selectedPollutant = pollutant.key
                    } label: {
                        PollutantRowView(
                            pollutant: pollutant.key,
                            quantity: pollutant.value.convert(
                                to: pollutant.key.measureUnit,
                                with: pollutant.key.molecularWeight
                            )
                        )
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    HomeView()
}
