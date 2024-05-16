//
//  AirPollutionDataModel.swift
//  Air Quality Charts
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
    let components: PollutantsDataModel

    enum CodingKeys: String, CodingKey {
        case dateTime = "dt"
        case AQI = "main"
        case components
    }

    func toModel() -> TimePollutionModel {
        .init(
            dateTime: Date(timeIntervalSince1970: dateTime),
            AQI: AQI.AQI,
            components: components.toModel()
        )
    }
}

struct AQIDataModel: Codable {
    let AQI: Double

    enum CodingKeys: String, CodingKey {
        case AQI = "aqi"
    }
}

// swiftlint: disable identifier_name
struct PollutantsDataModel: Codable {
    let co: Double
    let no: Double
    let no2: Double
    let o3: Double
    let so2: Double
    let pm25: Double
    let pm10: Double
    let nh3: Double

    enum CodingKeys: String, CodingKey {
        case co
        case no
        case no2
        case o3
        case so2
        case pm25 = "pm2_5"
        case pm10
        case nh3
    }

    func toModel() -> PollutantsModel {
        .init(
            co: co,
            no: no,
            no2: no2,
            o3: o3,
            so2: so2,
            pm25: pm25,
            pm10: pm10,
            nh3: nh3
        )
    }
}

// swiftlint: enable identifier_name
