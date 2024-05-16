//
//  RemoteRepositoriesDependencies.swift
//  Air Quality Charts
//
//  Created by Ennio Italiano on 12/05/24.
//

import Dependencies
import Foundation

enum APRemoteRepositoryDependencyKey: DependencyKey {
    static var liveValue: AirPollutionRemoteRepository {
        return AirPollutionLiveRemoteRepository()
    }
}

extension DependencyValues {
    var airPollutionRemoteRepository: AirPollutionRemoteRepository {
        get { self[APRemoteRepositoryDependencyKey.self] }
        set { self[APRemoteRepositoryDependencyKey.self] = newValue }
    }
}
