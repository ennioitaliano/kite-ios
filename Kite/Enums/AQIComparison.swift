//
//  AQIComparison.swift
//  Kite
//
//  Created by Ennio Italiano on 22/01/25.
//


enum AQIComparison: String {
    case betterThanYesterday = "Better than yesterday at this time."
    case worseThanYesterday = "Worse than yesterday at this time."
    case sameAsYesterday = "Same as yesterday at this time."
    
    init(yesterdayValue: AirQualityIndex, todayValue: AirQualityIndex) {
        if todayValue < yesterdayValue {
            self = .betterThanYesterday
        } else if todayValue == yesterdayValue {
            self = .sameAsYesterday
        } else {
            self = .worseThanYesterday
        }
    }
}
