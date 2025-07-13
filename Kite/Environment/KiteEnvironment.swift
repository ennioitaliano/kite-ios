//
//  KiteEnvironment.swift
//  Kite
//
//  Created by Ennio Italiano on 12/05/24.
//

import Foundation

protocol EnvironmentAPI: Sendable {
    var baseURL: URL { get }
    var APIKey: String { get }
}

struct KiteEnvironment: EnvironmentAPI {
    let baseURLPath: String = "https://api.openweathermap.org"
    var baseURL: URL {
        URL(string: baseURLPath)!
    }
}
