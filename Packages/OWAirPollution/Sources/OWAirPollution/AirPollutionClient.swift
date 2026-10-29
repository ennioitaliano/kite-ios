//
//  AirPollutionClient.swift
//  OWAirPollution
//
//  Created by Ennio Italiano on 30/09/25.
//

import Dependencies
import CoreLocation

public protocol AirPollutionService {
    static func configure(apiKey: String) throws
    static func getAirPollutionClient() throws -> AirPollutionService
    func getCurrent(for location: CLLocation) async throws -> AirPollutionModel
    func getHistorical(for location: CLLocation, interval: DateInterval) async throws -> AirPollutionModel
    func getForecast(for location: CLLocation) async throws -> AirPollutionModel
}

public class AirPollutionClient: AirPollutionService {
    @Dependency(\.airPollutionRemoteRepository) private var remoteRepository
    @Dependency(\.apiKeyStorage) private var apiKeyStorage

    private static var shared: AirPollutionService?

    private init(apiKey: String) {
        apiKeyStorage.setKey(apiKey)
    }

    public static func configure(apiKey: String) throws {
        guard AirPollutionClient.shared == nil else {
            throw ConfigurationError.clientAlreadyConfigured
        }
        AirPollutionClient.shared = AirPollutionClient(apiKey: apiKey)
    }

    public static func getAirPollutionClient() throws -> AirPollutionService {
        guard let shared = AirPollutionClient.shared else {
            throw ConfigurationError.clientNotConfigured
        }
        return shared
    }

    public func getCurrent(for location: CLLocation) async throws -> AirPollutionModel {
        try await remoteRepository.getCurrent(
            lat: location.coordinate.latitude,
            lon: location.coordinate.longitude
        )
    }

    public func getHistorical(for location: CLLocation, interval: DateInterval) async throws -> AirPollutionModel {
        try await remoteRepository.getHistorical(
            lat: location.coordinate.latitude,
            lon: location.coordinate.longitude,
            start: Int(interval.start.timeIntervalSince1970),
            end: Int(interval.end.timeIntervalSince1970)
        )
    }

    public func getForecast(for location: CLLocation) async throws -> AirPollutionModel {
        try await remoteRepository.getForecast(
            lat: location.coordinate.latitude,
            lon: location.coordinate.longitude
        )
    }
}
