//
//  CredentialStorageDependencies.swift
//  OWAirPollution
//
//  Created by Ennio Italiano on 30/09/25.
//

import Dependencies
import Foundation

enum APIKeyStorageDependencyKey: DependencyKey {
    static var liveValue: APIKeyStorage {
        APIKeyLiveStorage()
    }
}

extension DependencyValues {
    var apiKeyStorage: APIKeyStorage {
        get { self[APIKeyStorageDependencyKey.self] }
        set { self[APIKeyStorageDependencyKey.self] = newValue }
    }
}
