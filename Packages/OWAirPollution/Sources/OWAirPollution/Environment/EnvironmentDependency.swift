//
//  EnvironmentDependency.swift
//  Kite
//
//  Created by Ennio Italiano on 12/05/24.
//

import Dependencies
import Foundation

enum EnvironmentDependencyKeys: DependencyKey {
    static var liveValue: EnvironmentAPI {
        KiteEnvironment()
    }
}

extension DependencyValues {
    var environment: EnvironmentAPI {
        get { self[EnvironmentDependencyKeys.self] }
        set { self[EnvironmentDependencyKeys.self] = newValue }
    }
}
