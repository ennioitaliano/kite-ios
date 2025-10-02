//
//  AirQualityIndexView.swift
//  Kite
//
//  Created by Ennio Italiano on 17/01/25.
//

import OWAirPollution
import SwiftUI

struct AirQualityIndexView: View {
    @Environment(\.colorScheme) private var colorScheme
    let airQualityIndex: AirQualityIndex

    init(_ airQualityIndex: AirQualityIndex) {
        self.airQualityIndex = airQualityIndex
    }

    @ViewBuilder
    var body: some View {
        VStack(spacing: 10) {
            aqiIcon
            VStack(spacing: 0) {
                aqiSubtitle
                aqiValue
            }
        }
    }

    private var aqiIcon: some View {
        Image(systemName: airQualityIndex.icon)
            .font(.system(size: 30, weight: aqiIconFontWeight))
            .foregroundStyle(airQualityIndex.color.gradient, Color(UIColor.label))
    }

    private var aqiSubtitle: some View {
        Text("Air Quality is currently".uppercased())
            .font(.system(size: 10, design: .rounded))
            .foregroundStyle(Color(UIColor.secondaryLabel))
    }

    private var aqiValue: some View {
        Text(airQualityIndex.string.uppercased())
            .font(.system(size: 36, design: .rounded))
            .foregroundStyle(Color(UIColor.label))
    }
}

extension AirQualityIndexView {
    private var aqiIconFontWeight: Font.Weight? {
        if airQualityIndex != .poor &&
            airQualityIndex != .veryPoor {
            .black
        } else {
            nil
        }
    }
}

#Preview {
    AirQualityIndexView(.moderate)
}
