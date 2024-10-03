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

    func getCurrentAirPollution() async {
        do {
            airPollution = try await airPollutionRemoteRepository.getCurrent(for: CLLocationCoordinate2D(
                latitude: 50,
                longitude: 50
            ))
        } catch {
            logger.logError(.general, "Error: \(error.localizedDescription)")
        }
    }
}
