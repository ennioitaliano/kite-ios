//
//  AirQualityIndex.swift
//  Kite
//
//  Created by Ennio Italiano on 22/01/25.
//

import SwiftUI

enum AirQualityIndex: Int, Comparable {
    case good = 1
    case fair = 2
    case moderate = 3
    case poor = 4
    case veryPoor = 5

    var string: String {
        switch self {
        case .good: "Good"
        case .fair: "Fair"
        case .moderate: "Moderate"
        case .poor: "Poor"
        case .veryPoor: "Very Poor"
        }
    }

    var color: Color {
        switch self {
        case .good:
            .blue
        case .fair:
            .green
        case .moderate:
            .yellow
        case .poor:
            .red
        case .veryPoor:
            .purple
        }
    }

    var icon: String {
        switch self {
        case .good:
            "aqi.low"
        case .fair, .moderate:
            "aqi.medium"
        case .poor, .veryPoor:
            "aqi.high"
        }
    }

    static func < (lhs: AirQualityIndex, rhs: AirQualityIndex) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}
