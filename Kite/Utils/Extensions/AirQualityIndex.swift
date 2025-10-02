//
//  AirQualityIndex.swift
//  Kite
//
//  Created by Ennio Italiano on 22/01/25.
//

import OWAirPollution
import SwiftUI

extension AirQualityIndex {
    var string: String {
        switch self {
        case .good: kAirQualityLevelGood
        case .fair: kAirQualityLevelFair
        case .moderate: kAirQualityLevelModerate
        case .poor: kAirQualityLevelPoor
        case .veryPoor: kAirQualityLevelVeryPoor
        }
    }

    var color: Color {
        switch self {
        case .good: .blue
        case .fair: .green
        case .moderate: .yellow
        case .poor: .red
        case .veryPoor: .purple
        }
    }

    var icon: String {
        switch self {
        case .good: "aqi.low"
        case .fair, .moderate: "aqi.medium"
        case .poor, .veryPoor: "aqi.high"
        }
    }
}
