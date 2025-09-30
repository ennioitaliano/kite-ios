//
//  AQIDataModel.swift
//  Kite
//
//  Created by Ennio Italiano on 28/09/25.
//

struct AQIDataModel: Codable {
    let airQualityIndex: Double

    enum CodingKeys: String, CodingKey {
        case airQualityIndex = "aqi"
    }

    func toModel() -> AirQualityIndex? {
        AirQualityIndex(rawValue: Int(airQualityIndex))
    }
}
