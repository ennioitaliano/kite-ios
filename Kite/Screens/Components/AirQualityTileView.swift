//
//  AirQualityTileView.swift
//  Kite
//
//  Created by Ennio Italiano on 17/01/25.
//

import SwiftUI

struct AirQualityTileView: View {
    @Environment(HomeViewModel.self) private var viewModel

    @ViewBuilder
    var body: some View {
        if let AQI = viewModel.airPollution?.list.first?.AQI {
            VStack(spacing: 10) {
                Image(systemName: AQI.icon)
                    .font(.system(size: 30))
                    .foregroundStyle(AQI.color.gradient, .white)
                VStack(spacing: 0) {
                    Text("Air Quality is currently".uppercased())
                        .fontDesign(.rounded)
                        .font(.system(size: 10))
                        .foregroundStyle(Color.gray)
                    Text(AQI.string.uppercased())
                        .fontDesign(.rounded)
                        .font(.system(size: 36))
                }
                if let comparisonSentence = viewModel.comparisonSentence {
                    Text(comparisonSentence)
                        .fontDesign(.rounded)
                        .font(.system(size: 16))
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                }
            }
            .foregroundStyle(.white)
            .padding(.horizontal, 40)
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    AirQualityTileView()
}
