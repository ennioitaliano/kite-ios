//
//  HomeView.swift
//  Air Quality Charts
//
//  Created by Ennio Italiano on 03/10/24.
//

import CoreLocation
import Dependencies
import SwiftUI

struct HomeView: View {
    @State var viewModel = HomeViewModel()

    var body: some View {
        VStack {
            CurrentDataView()
                .environment(viewModel)
        }
        .padding()
        .frame(maxHeight: .infinity, alignment: .top)
        .task {
            await viewModel.getCurrentAirPollution()
        }
    }
}

struct CurrentDataView: View {
    @Environment(HomeViewModel.self) private var viewModel

    var body: some View {
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
    }

    private var currentAQIView: some View {
        VStack {
            Text("Teolo")
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
            Text("O3")
            Text("is the primary pollutant")
        }
    }

    private var comparisonView: some View {
        Text("Air Quality is better than yesterday at this time")
    }
}

#Preview {
    HomeView()
}
