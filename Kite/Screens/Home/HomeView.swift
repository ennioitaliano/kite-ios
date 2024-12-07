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
    @State private var locationManager = LocationManager()

    var body: some View {
        VStack {
            CurrentDataView()
                .environment(viewModel)
                .environment(locationManager)
            Spacer()
            Button("Get data") {
                Task {
                    guard let location = locationManager.locationPlacemark?.location else { return }
                    await viewModel.getCurrentAirPollution(for: location)
                }
            }
        }
        .padding()
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

struct CurrentDataView: View {
    @Environment(HomeViewModel.self) private var viewModel
    @Environment(LocationManager.self) private var locationManager

    var body: some View {
        @Bindable var locationManager = locationManager

        VStack(spacing: 16) {
            currentAQIView
            HStack(spacing: 16) {
                Group {
                    primaryPollutantView
                    comparisonView
                }
                .frame(maxWidth: .infinity)
            }
        }
        .alert(
            "Location permission not granted",
            isPresented: $locationManager.locationErrorAlertPresenting
        ) { }
    }

    private var currentAQIView: some View {
        VStack {
            if let location = locationManager.locationPlacemark?.locality {
                Text("\(location)")
            } else {
                LocationButton(.currentLocation) {
                    locationManager.requestLocation()
                }
                .symbolVariant(.circle)
            }
            if let AQI = viewModel.airPollution?.list.first?.AQI {
                Text(String(AQI))
                    .fontDesign(.rounded)
                    .font(.largeTitle)
                    .fontWeight(.medium)
                Text("Poor")
            }
        }
    }

    private var primaryPollutantView: some View {
        VStack {
            if let primaryPollutant = viewModel.airPollution?.list.first?.primaryPollutant {
                Text(primaryPollutant.name)
                Text("is the primary pollutant")
            }
        }
    }

    private var comparisonView: some View {
        Text("Air Quality is better than yesterday at this time")
    }
}

#Preview {
    HomeView()
}
