//
//  CurrentModel.swift
//  Air Quality Charts
//
//  Created by Ennio Italiano on 09/05/24.
//

import Foundation

struct AirPollutionModel {
    let coordinates: [Double]
    let list: [TimePollutionModel]
}

struct TimePollutionModel {
    let dateTime: Date
    let AQI: Double
    let components: PollutantsModel
}

struct PollutantsModel {
    let co: Double
    let no: Double
    let no2: Double
    let o3: Double
    let so2: Double
    let pm25: Double
    let pm10: Double
    let nh3: Double
}
