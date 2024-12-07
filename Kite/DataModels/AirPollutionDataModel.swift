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
            location: CLLocationCoordinate2D(coordinates: coordinates),
            list: list.map { $0.toModel() }
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
    let AQI: AQIDataModel
    let components: [String: Double]

    enum CodingKeys: String, CodingKey {
        case dateTime = "dt"
        case AQI = "main"
        case components
    }

    func toModel() -> TimePollutionModel {
        .init(
            dateTime: Date(timeIntervalSince1970: dateTime),
            AQI: AQI.AQI,
            components: components
        )
    }
}

struct AQIDataModel: Codable {
    let AQI: Double

    enum CodingKeys: String, CodingKey {
        case AQI = "aqi"
    }
}
