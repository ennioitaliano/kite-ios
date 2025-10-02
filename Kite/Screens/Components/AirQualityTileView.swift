//
//  AirQualityTileView.swift
//  Kite
//
//  Created by Ennio Italiano on 17/01/25.
//

import OWAirPollution
import SwiftUI

struct AirQualityTileView: View {

    let airQualityIndex: AirQualityIndex
    let comparisonSentence: String

    @ViewBuilder
    var body: some View {
        VStack(spacing: 10) {
            aqiIcon
            VStack(spacing: 0) {
                aqiSubtitle
                aqiValue
            }
            aqiComparison
        }
        .foregroundStyle(.white)
        .padding(.horizontal, 40)
        .frame(maxWidth: .infinity)
    }

    private var aqiIcon: some View {
        Image(systemName: airQualityIndex.icon)
            .font(.system(size: 30))
            .foregroundStyle(airQualityIndex.color.gradient, .white)
    }

    private var aqiSubtitle: some View {
        Text("Air Quality is currently".uppercased())
            .fontDesign(.rounded)
            .font(.system(size: 10))
            .foregroundStyle(Color.gray)
    }

    private var aqiValue: some View {
        Text(airQualityIndex.string.uppercased())
            .fontDesign(.rounded)
            .font(.system(size: 36))
    }

    private var aqiComparison: some View {
        Text(comparisonSentence)
            .fontDesign(.rounded)
            .font(.system(size: 16))
            .multilineTextAlignment(.center)
            .lineLimit(2)
    }
}

#Preview {
    AirQualityTileView(
        airQualityIndex: .moderate,
        comparisonSentence: AQIComparison.worseThanYesterday.sentence
    )
}
