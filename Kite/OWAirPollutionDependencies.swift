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
    public static var liveValue: AirPollutionClient {
        AirPollutionLiveClient()
    }
}

public extension DependencyValues {
    var owAirPollutionClient: AirPollutionClient {
        get { self[OWAirPollutionDependencyKey.self] }
        set { self[OWAirPollutionDependencyKey.self] = newValue }
    }
}
