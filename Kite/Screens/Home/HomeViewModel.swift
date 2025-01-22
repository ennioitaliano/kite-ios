//
//  HomeViewModel.swift
//  Kite
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
    var comparisonSentence: String?
    var isDataLoading: Bool = false
    
    func getAirPollution(for location: CLLocation) async {
        isDataLoading = true
        defer { isDataLoading = false }
        
        await getCurrentAirPollution(for: location)
        await getYesterdayAirPollution(for: location)
    }
    
    private func getCurrentAirPollution(for location: CLLocation) async {
        do {
            airPollution = try await airPollutionRemoteRepository.getCurrent(for: CLLocationCoordinate2D(
                latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude
            ))
        } catch {
            logger.logError(.general, "Error: \(error.localizedDescription)")
        }
    }
    
    private func getYesterdayAirPollution(for location: CLLocation) async {
        let yesterday: Date = .now.advanced(by: -86400)
        do {
            let yesterdayAirPollutionData = try await airPollutionRemoteRepository.getHistorical(
                for: CLLocationCoordinate2D(
                    latitude: location.coordinate.latitude,
                    longitude: location.coordinate.longitude
                ),
                start: yesterday,
                end: yesterday.advanced(by: 3600)
            )
            if let yesterdayAQI = yesterdayAirPollutionData.list.first?.AQI,
               let todayAQI = airPollution?.list.first?.AQI {
                comparisonSentence = AQIComparison(yesterdayValue: yesterdayAQI, todayValue: todayAQI).rawValue
            }
        } catch {
            logger.logError(.general, "Error: \(error.localizedDescription)")
        }
    }
}
