//
//  AirPollutionDataModel.swift
//  Kite
//
//  Created by Ennio Italiano on 09/05/24.
//

import CoreLocation
import Foundation

struct AirPollutionDataModel: Codable {
    let coordinates: CoordinatesDataModel
    let list: [TimePollutionDataModel]

    enum CodingKeys: String, CodingKey {
        case coordinates = "coord"
        case list
    }

    func toModel() -> AirPollutionModel {
        .init(
            location: CLLocation(
                latitude: coordinates.latitude,
                longitude: coordinates.longitude
            ),
            list: list.map { $0.toModel()
            }
        )
    }
}

struct CoordinatesDataModel: Codable {
    let longitude: Double
    let latitude: Double

    enum CodingKeys: String, CodingKey {
        case longitude = "lon"
        case latitude = "lat"
    }
}

extension CLLocationCoordinate2D {
    init(coordinates: CoordinatesDataModel) {
        self = CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude
        )
    }
}

struct TimePollutionDataModel: Codable {
    let dateTime: Double
    let airQualityIndex: AQIDataModel
    let components: [String: Double]

    enum CodingKeys: String, CodingKey {
        case dateTime = "dt"
        case airQualityIndex = "main"
        case components
    }

    func toModel() -> TimePollutionModel {
        .init(
            dateTime: Date(timeIntervalSince1970: dateTime),
            airQualityIndex: airQualityIndex.toModel(),
            components: components.toModel()
        )
    }
}

struct AQIDataModel: Codable {
    let airQualityIndex: Double

    enum CodingKeys: String, CodingKey {
        case airQualityIndex = "aqi"
    }

    func toModel() -> AirQualityIndex? {
        AirQualityIndex(rawValue: Int(airQualityIndex))
    }
}
