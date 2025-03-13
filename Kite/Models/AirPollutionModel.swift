//
//  AirPollutionModel.swift
//  Kite
//
//  Created by Ennio Italiano on 09/05/24.
//

import CoreLocation
import Foundation
import SwiftUI

struct AirPollutionModel {
    let location: CLLocationCoordinate2D
    let list: [TimePollutionModel]
}

struct TimePollutionModel {
    let dateTime: Date
    let AQI: AirQualityIndex?
    let components: [Pollutant: Double]
}

extension TimePollutionModel {
    var primaryPollutant: (name: Pollutant, value: Double) {
        let maxValue = components.values.max()
        let primaryPollutantName = components.first(where: { $1 == maxValue })?.key
        return (name: primaryPollutantName ?? .co, value: maxValue ?? 0)
    }
}
