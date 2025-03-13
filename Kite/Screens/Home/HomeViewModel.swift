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
    @ObservationIgnored @Dependency(\.airPollutionUseCase) private var airPollutionUseCase
    @ObservationIgnored @Dependency(\.logger) private var logger

    var airPollution: AirPollutionModel?
    var pollutantsList: [Pollutant: Double]?
    var comparisonSentence: String?
    var isDataLoading: Bool = false

    func getAirPollution(for placemark: CLPlacemark) async {
        isDataLoading = true
        defer { isDataLoading = false }

        await getCurrentAirPollution(for: placemark)
        await getYesterdayAirPollution(for: placemark)
    }

    private func getCurrentAirPollution(for placemark: CLPlacemark) async {
        do {
            guard let location = placemark.location else { throw LocationError.unavailableLocation }
            airPollution = try await airPollutionUseCase.getCurrent(for: location)
            pollutantsList = airPollution?.list.first?.components.filter({ $0.value.rounded() > 0 })
        } catch {
            logger.logError(.general, "Error: \(error.localizedDescription)")
        }
    }

    private func getYesterdayAirPollution(for placemark: CLPlacemark) async {
        let yesterday: Date = .now.advanced(by: -86400)
        do {
            guard let location = placemark.location else { throw LocationError.unavailableLocation }
            let yesterdayAirPollutionData = try await airPollutionUseCase.getHistorical(
                for: location,
                interval: .init(start: yesterday, duration: 3600)
            )
            if let yesterdayAQI = yesterdayAirPollutionData.list.first?.AQI,
               let todayAQI = airPollution?.list.first?.AQI {
                comparisonSentence = AQIComparison(
                    between: yesterdayAQI,
                    and: todayAQI
                ).rawValue
            }
        } catch {
            logger.logError(.general, "Error: \(error.localizedDescription)")
        }
    }
}
