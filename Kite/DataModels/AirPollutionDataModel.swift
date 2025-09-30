//
//  AirPollutionDataModel.swift
//  Kite
//
//  Created by Ennio Italiano on 09/05/24.
//

import CoreLocation
import Foundation

nonisolated struct AirPollutionDataModel: Codable {
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
