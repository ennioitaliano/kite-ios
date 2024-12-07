//
//  GeocodingRemoteRepository.swift
//  Air Quality Charts
//
//  Created by Ennio Italiano on 16/05/24.
//

import Alamofire
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
        let request = AF.request(
            "\(environment.baseURL)/geo/1.0/direct",
            method: .get,
            parameters: [
                "q": location,
                "limit": String(limit),
                "appid": environment.APIKey
            ]
        )

        do {
            let response = try await request.serializingDecodable([GeocodingDataModel].self).value
            return response.map { $0.toModel() }
        } catch {
            logger.logError(.network, error.localizedDescription)
            throw error
        }
    }

    func getCoordinates(zipCode: String) async throws -> GeocodingModel {
        let request = AF.request(
            "\(environment.baseURL)/geo/1.0/zip",
            method: .get,
            parameters: [
                "zip": zipCode,
                "appid": environment.APIKey
            ]
        )

        do {
            let response = try await request.serializingDecodable(GeocodingDataModel.self).value
            return response.toModel()
        } catch {
            logger.logError(.network, error.localizedDescription)
            throw error
        }
    }

    func getLocation(for coordinates: CLLocationCoordinate2D, limit: Int) async throws -> [GeocodingModel] {
        let request = AF.request(
            "\(environment.baseURL)/geo/1.0/reverse",
            method: .get,
            parameters: [
                "lat": String(coordinates.latitude),
                "lon": String(coordinates.longitude),
                "limit": String(limit),
                "appid": environment.APIKey
            ]
        )

        do {
            let response = try await request.serializingDecodable([GeocodingDataModel].self).value
            return response.map{ $0.toModel() }
        } catch {
            logger.logError(.network, error.localizedDescription)
            throw error
        }
    }
}

enum GeocodingError: Error {
    case locationData
}
