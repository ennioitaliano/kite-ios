//
//  CoordinatesDataModel.swift
//  Kite
//
//  Created by Ennio Italiano on 28/09/25.
//

struct CoordinatesDataModel: Codable {
    let longitude: Double
    let latitude: Double

    enum CodingKeys: String, CodingKey {
        case longitude = "lon"
        case latitude = "lat"
    }
}
