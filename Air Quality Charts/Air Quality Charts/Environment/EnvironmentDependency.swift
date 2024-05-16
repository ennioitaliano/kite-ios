//
//  EnvironmentDependency.swift
//  Air Quality Charts
//
//  Created by Ennio Italiano on 12/05/24.
//

import Dependencies
import Foundation

enum EnvironmentDependencyKeys: DependencyKey {
    static var liveValue: EnvironmentAPI {
        Environment()
    }
}

extension DependencyValues {
    var environment: EnvironmentAPI {
        get { self[EnvironmentDependencyKeys.self] }
        set { self[EnvironmentDependencyKeys.self] = newValue }
    }
}
