//
//  UseCaseDependencies.swift
//  Kite
//
//  Created by Ennio Italiano on 12/03/25.
//

import Dependencies
import Foundation

enum AirPollutionUseCaseDependencyKey: DependencyKey {
    static var liveValue: AirPollutionUseCase {
        AirPollutionLiveUseCase()
    }
}

extension DependencyValues {
    var airPollutionUseCase: AirPollutionUseCase {
        get { self[AirPollutionUseCaseDependencyKey.self] }
        set { self[AirPollutionUseCaseDependencyKey.self] = newValue }
    }
}
