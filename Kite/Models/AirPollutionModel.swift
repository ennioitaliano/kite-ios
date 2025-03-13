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
    let location: CLLocation
    let list: [TimePollutionModel]
}

struct TimePollutionModel {
    let dateTime: Date
    let airQualityIndex: AirQualityIndex?
    let components: [Pollutant: Double]
}
