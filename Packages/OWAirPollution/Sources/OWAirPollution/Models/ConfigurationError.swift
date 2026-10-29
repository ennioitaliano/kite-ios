//
//  ConfigurationError.swift
//  OWAirPollution
//
//  Created by Ennio Italiano on 30/09/25.
//

import Foundation

public enum ConfigurationError: Error {
    case clientAlreadyConfigured
    case clientNotConfigured
}

extension ConfigurationError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .clientAlreadyConfigured:
            "Air pollution client has already been configured."
        case .clientNotConfigured:
            "Air pollution client hasn't been configured. Static configure(apiKey: String) function should be called before using it."
        }
    }
}
