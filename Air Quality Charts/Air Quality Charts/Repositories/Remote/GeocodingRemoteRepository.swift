//
//  GeocodingRemoteRepository.swift
//  Air Quality Charts
//
//  Created by Ennio Italiano on 16/05/24.
//

import CommonNetworking
import CoreLocation
import Dependencies
import Foundation

protocol GeocodingRemoteRepository {
    func getCoordinates(location: String, limit: Int) async throws -> [GeocodingModel]
    func getCoordinates(zipCode: String) async throws -> GeocodingModel
    func getCoordinates(for location: CLPlacemark, limit: Int) async throws -> [GeocodingModel]
    func getLocation(for coordinates: CLLocationCoordinate2D, limit: Int) async throws -> [GeocodingModel]
}

struct GeocodingLiveRemoteRepository: GeocodingRemoteRepository {
    @Dependency(\.environment) private var environment
    @Dependency(\.logger) private var logger

    private let client: APIClient<NetworkErrorDataModel>

    init(client: APIClient<NetworkErrorDataModel> = APIClient()) {
        self.client = client
    }

    func getCoordinates(for location: CLPlacemark, limit: Int) async throws -> [GeocodingModel] {
        var response: [GeocodingModel] = []

        if let location = location.APIString {
            response = try await getCoordinates(location: location, limit: limit)
        } else if let zipCode = location.APIStringZip {
            response.append(try await getCoordinates(zipCode: zipCode))
        } else {
            throw GeocodingError.locationData
        }

        return response
    }

    func getCoordinates(location: String, limit: Int) async throws -> [GeocodingModel] {
        let request = client.buildRequest(
            APIRequestSettings(
                url: environment.baseURL,
                urlPathComponent: "/geo/1.0/direct",
                urlQueryParameters: [
                    "q": location,
                    "limit": String(limit),
                    "appid": environment.APIKey
                ],
                httpMethod: .get,
                httpHeaderFields: [
                    Headers.contentType.rawValue: "application/json"
                ]
            )
        )

        do {
            let response: [GeocodingDataModel] = try await client.run(request)
            return response.map { $0.toModel() }
        } catch let networkError as NetworkError<NetworkErrorDataModel> {
            logger.logError(.network, networkError.localizedDescription)
            throw networkError
        }
    }

    func getCoordinates(zipCode: String) async throws -> GeocodingModel {
        let request = client.buildRequest(
            APIRequestSettings(
                url: environment.baseURL,
                urlPathComponent: "/geo/1.0/zip",
                urlQueryParameters: [
                    "zip": zipCode,
                    "appid": environment.APIKey
                ],
                httpMethod: .get,
                httpHeaderFields: [
                    Headers.contentType.rawValue: "application/json"
                ]
            )
        )

        do {
            let response: GeocodingDataModel = try await client.run(request)
            return response.toModel()
        } catch let networkError as NetworkError<NetworkErrorDataModel> {
            logger.logError(.network, networkError.localizedDescription)
            throw networkError
        }
    }

    func getLocation(for coordinates: CLLocationCoordinate2D, limit: Int) async throws -> [GeocodingModel] {
        let request = client.buildRequest(
            APIRequestSettings(
                url: environment.baseURL,
                urlPathComponent: "/geo/1.0/reverse",
                urlQueryParameters: [
                    "lat": String(coordinates.latitude),
                    "lon": String(coordinates.longitude),
                    "limit": String(limit),
                    "appid": environment.APIKey
                ],
                httpMethod: .get,
                httpHeaderFields: [
                    Headers.contentType.rawValue: "application/json"
                ]
            )
        )

        do {
            let response: [GeocodingDataModel] = try await client.run(request)
            return response.map { $0.toModel() }
        } catch let networkError as NetworkError<NetworkErrorDataModel> {
            logger.logError(.network, networkError.localizedDescription)
            throw networkError
        }
    }
}

enum GeocodingError: Error {
    case locationData
}
