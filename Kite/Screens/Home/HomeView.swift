//
//  HomeView.swift
//  Kite
//
//  Created by Ennio Italiano on 03/10/24.
//

import CoreLocation
import Dependencies
import SwiftUI

struct HomeView: View {
    @State private var viewModel: HomeViewModel = .init()
    @State private var showSearchSheet: Bool = false
    @State private var locationText: String = "Teolo, Italy"

    private func getAirPollution() async {
        if let placemark = viewModel.placemark {
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
        .task {
            await viewModel.getPlacemark(for: locationText)
            await getAirPollution()
        }
        .sheet(isPresented: $showSearchSheet) {
            Task {
                await getAirPollution()
            }
        } content: {
            LocationChoiceView(locationSearchText: $locationText)
                .environment(viewModel)
        }
    }

    @ViewBuilder
    private var searchLocationButton: some View {
        Button {
            showSearchSheet = true
        } label: {
            Label(locationText, systemImage: locationText == "Teolo, Italy" ? "location.fill" : "magnifyingglass")
                .font(.system(size: 14))
                .foregroundStyle(.white)
                .labelStyle(.titleAndIcon)
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
