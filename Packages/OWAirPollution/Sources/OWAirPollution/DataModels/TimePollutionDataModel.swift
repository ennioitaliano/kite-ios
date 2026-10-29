//
//  TimePollutionDataModel.swift
//  Kite
//
//  Created by Ennio Italiano on 28/09/25.
//

import Foundation

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

extension [String: Double] {
    func toModel() -> [Pollutant: Double] {
        reduce(into: [:]) { result, element in
            guard let pollutant = Pollutant(rawValue: element.key) else { return }
            result[pollutant] = element.value
        }
    }
}
