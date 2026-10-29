//
//  APIKeyStorage.swift
//  OWAirPollution
//
//  Created by Ennio Italiano on 30/09/25.
//

protocol APIKeyStorage {
    func setKey(_ key: String)
    func getKey() throws -> String
}

class APIKeyLiveStorage: APIKeyStorage {
    private var apiKey: String?

    func setKey(_ key: String) {
        self.apiKey = key
    }

    func getKey() throws -> String {
        guard let apiKey else {
            throw CredentialStorageError.credentialNotSet
        }
        return apiKey
    }
}
