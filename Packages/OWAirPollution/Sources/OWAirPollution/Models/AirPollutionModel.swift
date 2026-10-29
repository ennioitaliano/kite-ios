//
//  AirPollutionModel.swift
//  Kite
//
//  Created by Ennio Italiano on 09/05/24.
//

import CoreLocation
import Foundation
import SwiftUI

public struct AirPollutionModel {
    let location: CLLocation
    public let list: [TimePollutionModel]
}

public struct TimePollutionModel {
    let dateTime: Date
    public let airQualityIndex: AirQualityIndex?
    public let components: [Pollutant: Double]
}
