//
//  AirPollutionUseCase.swift
//  Kite
//
//  Created by Ennio Italiano on 12/03/25.
//

import CoreLocation
import Dependencies
import Foundation

protocol AirPollutionUseCase {
    func getCurrent(for location: CLLocation) async throws -> AirPollutionModel
    
    func getHistorical(
        for location: CLLocation,
        interval: DateInterval
    ) async throws -> AirPollutionModel
}

struct AirPollutionLiveUseCase: AirPollutionUseCase {
    
    @Dependency(\.airPollutionRemoteRepository) private var airPollutionRepository
    
    func getCurrent(for location: CLLocation) async throws -> AirPollutionModel {
        try await airPollutionRepository.getCurrent(
            lat: location.coordinate.latitude,
            lon: location.coordinate.longitude
        )
    }
    
    func getHistorical(
        for location: CLLocation,
        interval: DateInterval
    ) async throws -> AirPollutionModel {
        try await airPollutionRepository.getHistorical(
            lat: location.coordinate.latitude,
            lon: location.coordinate.longitude,
            start: Int(interval.start.timeIntervalSince1970),
            end: Int(interval.end.timeIntervalSince1970)
        )
    }
}
