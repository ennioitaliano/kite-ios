//
//  AirPollutionRemoteRepository.swift
//  Air Quality Charts
//
//  Created by Ennio Italiano on 12/05/24.
//

import Alamofire
import CoreLocation
import Dependencies
import Foundation

protocol AirPollutionRemoteRepository {
    func getCurrent(for location: CLLocationCoordinate2D) async throws -> AirPollutionModel
    func getForecast(for location: CLLocationCoordinate2D) async throws -> AirPollutionModel
    func getHistorical(for location: CLLocationCoordinate2D, start: Date, end: Date) async throws -> AirPollutionModel
}

struct AirPollutionLiveRemoteRepository: AirPollutionRemoteRepository {
    @Dependency(\.environment) private var environment
    @Dependency(\.logger) private var logger

    func getCurrent(for location: CLLocationCoordinate2D) async throws -> AirPollutionModel {
        let request = AF.request(
            "\(environment.baseURL)/data/2.5/air_pollution",
            method: .get,
            parameters: [
                "lat": "\(location.latitude)",
                "lon": "\(location.longitude)",
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

    func getForecast(for location: CLLocationCoordinate2D) async throws -> AirPollutionModel {
        let request = AF.request(
            "\(environment.baseURL)/data/2.5/air_pollution/forecast",
            method: .get,
            parameters: [
                "lat": "\(location.latitude)",
                "lon": "\(location.longitude)",
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

    func getHistorical(for location: CLLocationCoordinate2D, start: Date, end: Date) async throws -> AirPollutionModel {
        let request = AF.request(
            "\(environment.baseURL)/data/2.5/air_pollution/history",
            method: .get,
            parameters: [
                "lat": "\(location.latitude)",
                "lon": "\(location.longitude)",
                "start": "\(Int(start.timeIntervalSince1970))",
                "end": "\(Int(end.timeIntervalSince1970))",
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
