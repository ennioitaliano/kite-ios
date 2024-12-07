//
//  HomeViewModel.swift
//  Air Quality Charts
//
//  Created by Ennio Italiano on 03/10/24.
//

import CoreLocation
import Dependencies
import Foundation

@Observable
class HomeViewModel {
    @ObservationIgnored @Dependency(\.airPollutionRemoteRepository) private var airPollutionRemoteRepository
    @ObservationIgnored @Dependency(\.geocodingRemoteRepository) private var geoCodingRemoteRepository
    @ObservationIgnored @Dependency(\.logger) private var logger

    var airPollution: AirPollutionModel?

    func getCurrentAirPollution(for location: CLLocation) async {
        do {
            airPollution = try await airPollutionRemoteRepository.getCurrent(for: CLLocationCoordinate2D(
                latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude
            ))
        } catch {
            logger.logError(.general, "Error: \(error.localizedDescription)")
        }
    }
}
