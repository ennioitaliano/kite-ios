//
//  GeocodingDataModel.swift
//  Air Quality Charts
//
//  Created by Ennio Italiano on 09/05/24.
//

import CoreLocation
import Foundation

struct GeocodingDataModel: Codable {
    let name: String
    let localNames: LocalNamesDataModel
    let latitude: Double
    let longitude: Double
    let country: String
    let state: String?

    enum CodingKeys: String, CodingKey {
        case name
        case localNames = "local_names"
        case latitude = "lat"
        case longitude = "long"
        case country
        case state
    }

    func toModel() -> GeocodingModel {
        .init(
            name: name,
            localNames: localNames.toModel(),
            coordinates: CLLocationCoordinate2D(
                latitude: latitude,
                longitude: longitude
            ),
            country: country,
            state: state
        )
    }
}

struct LocalNamesDataModel: Codable {
    let featureName: String
    let ASCIIName: String
    let italianName: String?

    enum CodingKeys: String, CodingKey {
        case featureName = "feature_name"
        case ASCIIName = "ascii"
        case italianName = "it"
    }

    func toModel() -> LocalNamesModel {
        .init(
            featureName: featureName,
            ASCIIName: ASCIIName,
            italianName: italianName
        )
    }
}
