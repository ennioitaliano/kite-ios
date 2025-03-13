//
//  AQIComparison.swift
//  Kite
//
//  Created by Ennio Italiano on 22/01/25.
//

enum AQIComparison: String {
    case betterThanYesterday = "Better than yesterday at this time."
    case worseThanYesterday = "Worse than yesterday at this time."
    case sameAsYesterday = "Similar to yesterday at this time."

    init(
        between yesterdayValue: AirQualityIndex,
        and todayValue: AirQualityIndex
    ) {
        self = if todayValue < yesterdayValue {
            .betterThanYesterday
        } else if todayValue == yesterdayValue {
            .sameAsYesterday
        } else {
            .worseThanYesterday
        }
    }
}
