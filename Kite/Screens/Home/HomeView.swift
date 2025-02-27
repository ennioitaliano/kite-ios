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
            KiteList {
                aqiInfo
                pollutantList
            }
            .background(Color.black.brightness(0.25).ignoresSafeArea())
            .toolbar(.hidden)
            .refreshable {
                await viewModel.getAirPollution(
                    for: .init(
                        latitude: .init(45.4642),
                        longitude: .init(11.1900)
                    )
                )
            }
        }
        .preferredColorScheme(.dark)
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
                .padding(.bottom, 22)
        }
    }
    
    @ViewBuilder
    private var pollutantList: some View {
        if let pollutants = viewModel.airPollution?.list.first?.components.filter({ $0.value > 0 }).sorted(by: { $0.value > $1.value }) {
            ForEach(pollutants, id: \.key) { pollutant in
                PollutantRowView(pollutant: pollutant.key, quantity: pollutant.value)
                    .padding(.top, 12)
            }
            .padding(.horizontal)
        }
    }
}

struct KiteList<Content: View>: View {
    
    let content: Content
    
    init(@ViewBuilder _ content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        List {
            content
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .listSectionSeparator(.hidden)
        }
        .listStyle(.plain)
        .contentMargins(.top, 16)
        .contentMargins(.horizontal, 0)
        .contentMargins(.bottom, 0)
        .scrollIndicators(.hidden)
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    HomeView()
}
