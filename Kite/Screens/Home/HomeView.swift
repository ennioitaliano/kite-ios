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
        KiteList {
            aqiInfo
            pollutantsList
        }
        .background(Color.black.brightness(0.25).ignoresSafeArea())
        .refreshable {
            await viewModel.getAirPollution(
                for: .init(
                    latitude: .init(45.4642),
                    longitude: .init(11.1900)
                )
            )
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
    private var aqiInfo: some View {
        if let AQI = viewModel.airPollution?.list.first?.AQI {
            AirQualityTileView(AQI: AQI)
                .environment(viewModel)
                .padding(.bottom, 32)
        }
    }
    
    @ViewBuilder
    private var pollutantsList: some View {
        if let pollutants = viewModel.airPollution?.list.first?.components.filter({ $0.value > 0 }).sorted(by: { $0.value > $1.value }) {
            ForEach(pollutants, id: \.key) { pollutant in
                PollutantRowView(pollutant: pollutant.key, quantity: pollutant.value)
                    .padding(.bottom, 12)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    HomeView()
}
