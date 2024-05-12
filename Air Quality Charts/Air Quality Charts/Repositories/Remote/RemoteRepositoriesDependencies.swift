//
//  RemoteRepositoriesDependencies.swift
//  Air Quality Charts
//
//  Created by Ennio Italiano on 12/05/24.
//

import Dependencies
import Foundation


enum AirPollutionRemoteRepositoryDependencyKey: DependencyKey {
    static var liveValue: AirPollutionRemoteRepository {
        return AirPollutionLiveRemoteRepository()
    }
}

extension DependencyValues {
    var airPollutionRemoteRepository: AirPollutionRemoteRepository {
        get { self[AirPollutionRemoteRepositoryDependencyKey.self] }
        set { self[AirPollutionRemoteRepositoryDependencyKey.self] = newValue }
    }
}
