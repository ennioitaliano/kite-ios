//
//  AirPollutionRemoteRepository.swift
//  Kite
//
//  Created by Ennio Italiano on 12/05/24.
//

import Alamofire
import CoreLocation
import Dependencies
import Foundation

protocol AirPollutionRemoteRepository {
    func getCurrent(
        lat latitude: CLLocationDegrees,
        lon longitude: CLLocationDegrees
    ) async throws -> AirPollutionModel

    func getForecast(
        lat latitude: CLLocationDegrees,
        lon longitude: CLLocationDegrees
    ) async throws -> AirPollutionModel

    func getHistorical(
        lat latitude: CLLocationDegrees,
        lon longitude: CLLocationDegrees,
        start: Int,
        end: Int
    ) async throws -> AirPollutionModel
}

struct AirPollutionLiveRemoteRepository: AirPollutionRemoteRepository {
    @Dependency(\.environment) private var environment
    @Dependency(\.logger) private var logger

    func getCurrent(
        lat latitude: CLLocationDegrees,
        lon longitude: CLLocationDegrees
    ) async throws -> AirPollutionModel {
        let request = AF.request(
            "\(environment.baseURL)/data/2.5/air_pollution",
            method: .get,
            parameters: [
                "lat": "\(latitude)",
                "lon": "\(longitude)",
                "appid": "\(environment.APIKey)"
            ]
        )

        do {
            let response = try await request.serializingDecodable(AirPollutionDataModel.self).value
            return response.toModel()
        } catch {
            logger.logError(.network, error.localizedDescription)
            throw error
        }
    }

    func getForecast(
        lat latitude: CLLocationDegrees,
        lon longitude: CLLocationDegrees
    ) async throws -> AirPollutionModel {
        let request = AF.request(
            "\(environment.baseURL)/data/2.5/air_pollution/forecast",
            method: .get,
            parameters: [
                "lat": "\(latitude)",
                "lon": "\(longitude)",
                "appid": "\(environment.APIKey)"
            ]
        )

        do {
            let response = try await request.serializingDecodable(AirPollutionDataModel.self).value
            return response.toModel()
        } catch {
            logger.logError(.network, error.localizedDescription)
            throw error
        }
    }

    func getHistorical(
        lat latitude: CLLocationDegrees,
        lon longitude: CLLocationDegrees,
        start: Int,
        end: Int
    ) async throws -> AirPollutionModel {
        let request = AF.request(
            "\(environment.baseURL)/data/2.5/air_pollution/history",
            method: .get,
            parameters: [
                "lat": "\(latitude)",
                "lon": "\(longitude)",
                "start": "\(start)",
                "end": "\(end)",
                "appid": "\(environment.APIKey)"
            ]
        )

        do {
            let response = try await request.serializingDecodable(AirPollutionDataModel.self).value
            return response.toModel()
        } catch {
            logger.logError(.network, error.localizedDescription)
            throw error
        }
    }
}
