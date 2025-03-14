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

    private var airPollutionData: TimePollutionModel?
    var airQualityIndex: AirQualityIndex?
    var pollutantsList: [Pollutant: Double]?
    var comparisonSentence: String?
    var isDataLoading: Bool = false
    var placemark: CLPlacemark?

    func getPlacemark(for locationSearchText: String) async {
        let geocoder = CLGeocoder()
        placemark = try? await geocoder.geocodeAddressString(locationSearchText).first
    }

    func getAirPollution(for placemark: CLPlacemark) async {
        isDataLoading = true
        defer { isDataLoading = false }

        await getCurrentAirPollution(for: placemark)
        await getYesterdayAirPollution(for: placemark)
    }

    private func getCurrentAirPollution(for placemark: CLPlacemark) async {
        do {
            guard let location = placemark.location else { throw LocationError.unavailableLocation }
            airPollutionData = try await airPollutionUseCase.getCurrent(for: location).list.first
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
            let yesterdayAirPollutionData = try await airPollutionUseCase.getHistorical(
                for: location,
                interval: .init(start: yesterday, duration: 3600)
            ).list.first
            if let yesterdayAQI = yesterdayAirPollutionData?.airQualityIndex,
               let todayAQI = airPollutionData?.airQualityIndex {
                comparisonSentence = AQIComparison(
                    between: yesterdayAQI,
                    and: todayAQI
                ).sentence
            }
        } catch {
            logger.logError(.general, "Error: \(error.localizedDescription)")
        }
    }
}
