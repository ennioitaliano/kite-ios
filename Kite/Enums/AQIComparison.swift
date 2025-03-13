//
//  AQIComparison.swift
//  Kite
//
//  Created by Ennio Italiano on 22/01/25.
//

enum AQIComparison {
    case betterThanYesterday
    case worseThanYesterday
    case sameAsYesterday

    init(
        between yesterdayValue: AirQualityIndex,
        and todayValue: AirQualityIndex
    ) {
        self = if todayValue < yesterdayValue {
            .betterThanYesterday
        } else if todayValue > yesterdayValue {
            .worseThanYesterday
        } else {
            .sameAsYesterday
        }
    }

    var sentence: String {
        switch self {
        case .betterThanYesterday: kComparisonBetter
        case .worseThanYesterday: kComparisonWorse
        case .sameAsYesterday: kComparisonSimilar
        }
    }
}
