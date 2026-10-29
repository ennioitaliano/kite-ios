//
//  AirQualityIndex.swift
//  OWAirPollution
//
//  Created by Ennio Italiano on 30/09/25.
//

public enum AirQualityIndex: Int {
    case good = 1
    case fair = 2
    case moderate = 3
    case poor = 4
    case veryPoor = 5
}

extension AirQualityIndex: Comparable {
    public static func < (lhs: AirQualityIndex, rhs: AirQualityIndex) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}
