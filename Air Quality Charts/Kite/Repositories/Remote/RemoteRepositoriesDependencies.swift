//
//  RemoteRepositoriesDependencies.swift
//  Kite
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

enum GCRemoteRepositoryDependencyKey: DependencyKey {
    static var liveValue: GeocodingRemoteRepository {
        return GeocodingLiveRemoteRepository()
    }
}

extension DependencyValues {
    var airPollutionRemoteRepository: AirPollutionRemoteRepository {
        get { self[APRemoteRepositoryDependencyKey.self] }
        set { self[APRemoteRepositoryDependencyKey.self] = newValue }
    }

    var geocodingRemoteRepository: GeocodingRemoteRepository {
        get { self[GCRemoteRepositoryDependencyKey.self] }
        set { self[GCRemoteRepositoryDependencyKey.self] = newValue }
    }
}
