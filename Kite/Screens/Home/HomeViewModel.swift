//
//  HomeViewModel.swift
//  Kite
//
//  Created by Ennio Italiano on 03/10/24.
//

import CommonLogging
import CoreLocation
import Dependencies
import Foundation
import OWAirPollution

@MainActor
@Observable
class HomeViewModel {
    @ObservationIgnored @Dependency(\.owAirPollutionClient) private var airPollutionClient
    @ObservationIgnored @Dependency(\.logger) private var logger

    private var airPollutionData: TimePollutionModel?
    private var yesterdayAirPollutionData: TimePollutionModel?
    var airQualityIndex: AirQualityIndex?
    var pollutantsList: [Pollutant: Double]?
    var comparisonSentence: String?
    var isDataLoading: Bool = false

    init() {
        configureAirPollution()
    }

    func configureAirPollution() {
        do {
            try AirPollutionClient.configure(apiKey: Secrets.APIKey)
        } catch {
            logger.logError(.airPollutionClient, error.localizedDescription)
        }
    }

    func getAirPollution(for placemark: CLPlacemark) async {
        isDataLoading = true
        defer { isDataLoading = false }

        await withTaskGroup { [weak self] group in
            group.addTask {
                await self?.getCurrentAirPollution(for: placemark)
            }
            group.addTask {
                await self?.getYesterdayAirPollution(for: placemark)
            }
        }

        getComparisonSentence()
    }

    private func getCurrentAirPollution(for placemark: CLPlacemark) async {
        do {
            guard let location = placemark.location else { throw LocationError.unavailableLocation }
            airPollutionData = try await airPollutionClient.getCurrent(for: location).list.first
            pollutantsList = airPollutionData?.components.filter({ $0.value.rounded() > 0 })
            airQualityIndex = airPollutionData?.airQualityIndex
        } catch {
            logger.logError(.general, "Error: \(error.localizedDescription)")
        }
    }

    private func getYesterdayAirPollution(for placemark: CLPlacemark) async {
        let yesterday: Date = .now.advanced(by: -86400)
        do {
            guard let location = placemark.location else { throw LocationError.unavailableLocation }
            yesterdayAirPollutionData = try await airPollutionClient.getHistorical(
                for: location,
                interval: .init(start: yesterday, duration: 3600)
            ).list.first
        } catch {
            logger.logError(.general, "Error: \(error.localizedDescription)")
        }
    }

    private func getComparisonSentence() {
        guard let yesterdayAQI = yesterdayAirPollutionData?.airQualityIndex,
              let todayAQI = airPollutionData?.airQualityIndex
        else { return }
        comparisonSentence = AQIComparison(
            between: yesterdayAQI,
            and: todayAQI
        ).sentence
    }
}
