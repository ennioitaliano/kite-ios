//
//  CredentialStorageError.swift
//  OWAirPollution
//
//  Created by Ennio Italiano on 30/09/25.
//

import Foundation

enum CredentialStorageError: Error {
    case credentialNotSet
}

extension CredentialStorageError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .credentialNotSet:
            "API key not provided. Call setKey(_ apiKey: String) to set it."
        }
    }
}
