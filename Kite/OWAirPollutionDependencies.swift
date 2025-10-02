//
//  OWAirPollutionDependencies.swift
//  Kite
//
//  Created by Ennio Italiano on 12/03/25.
//

import Dependencies
import Foundation
import OWAirPollution

public enum OWAirPollutionDependencyKey: DependencyKey {
    public static var liveValue: AirPollutionService {
        try! AirPollutionClient.getAirPollutionClient()
    }
}

public extension DependencyValues {
    var owAirPollutionClient: AirPollutionService {
        get { self[OWAirPollutionDependencyKey.self] }
        set { self[OWAirPollutionDependencyKey.self] = newValue }
    }
}
