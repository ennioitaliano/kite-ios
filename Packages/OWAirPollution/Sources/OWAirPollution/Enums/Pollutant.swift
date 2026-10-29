//
//  Pollutant.swift
//  OWAirPollution
//
//  Created by Ennio Italiano on 30/09/25.
//

public enum Pollutant: String {
    case co
    case no2
    case o3
    case so2
    case pm2_5
    case pm10
    case nh3
    case no
}

extension Pollutant: Identifiable {
    public var id: String {
        rawValue
    }
}
