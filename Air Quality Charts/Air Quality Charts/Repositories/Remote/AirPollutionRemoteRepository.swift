//
//  AirPollutionRemoteRepository.swift
//  Air Quality Charts
//
//  Created by Ennio Italiano on 12/05/24.
//

import CommonNetworking
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

    private let client: APIClient<NetworkErrorDataModel>

    init(client: APIClient<NetworkErrorDataModel> = APIClient()) {
        self.client = client
    }

    func getCurrent(for location: CLLocationCoordinate2D) async throws -> AirPollutionModel {
        let request = client.buildRequest(
            APIRequestSettings(
                url: environment.baseURL,
                urlPathComponent: "/data/2.5/air_pollution",
                urlQueryParameters: [
                    "lat": "\(location.latitude)",
                    "lon": "\(location.longitude)",
                    "appid": "\(environment.APIKey)"
                ],
                httpMethod: .get,
                httpHeaderFields: [
                    Headers.contentType.rawValue: "application/json"
                ]
            )
        )

        do {
            let response: AirPollutionDataModel = try await client.run(request)
            return response.toModel()
        } catch let networkError as NetworkError<NetworkErrorDataModel> {
            logger.logError(.network, networkError.localizedDescription)
            throw networkError
        }
    }

    func getForecast(for location: CLLocationCoordinate2D) async throws -> AirPollutionModel {
        let request = client.buildRequest(
            APIRequestSettings(
                url: environment.baseURL,
                urlPathComponent: "/data/2.5/air_pollution/forecast",
                urlQueryParameters: [
                    "lat": "\(location.latitude)",
                    "lon": "\(location.longitude)",
                    "appid": "\(environment.APIKey)"
                ],
                httpMethod: .get,
                httpHeaderFields: [
                    Headers.contentType.rawValue: "application/json"
                ]
            )
        )

        do {
            let response: AirPollutionDataModel = try await client.run(request)
            return response.toModel()
        } catch let networkError as NetworkError<NetworkErrorDataModel> {
            logger.logError(.network, networkError.localizedDescription)
            throw networkError
        }
    }

    func getHistorical(for location: CLLocationCoordinate2D, start: Date, end: Date) async throws -> AirPollutionModel {
        let request = client.buildRequest(
            APIRequestSettings(
                url: environment.baseURL,
                urlPathComponent: "/data/2.5/air_pollution/history",
                urlQueryParameters: [
                    "lat": "\(location.latitude)",
                    "lon": "\(location.longitude)",
                    "start": "\(Int(start.timeIntervalSince1970))",
                    "end": "\(Int(end.timeIntervalSince1970))",
                    "appid": "\(environment.APIKey)"
                ],
                httpMethod: .get,
                httpHeaderFields: [
                    Headers.contentType.rawValue: "application/json"
                ]
            )
        )

        do {
            let response: AirPollutionDataModel = try await client.run(request)
            return response.toModel()
        } catch let networkError as NetworkError<NetworkErrorDataModel> {
            logger.logError(.network, networkError.localizedDescription)
            throw networkError
        }
    }
}
