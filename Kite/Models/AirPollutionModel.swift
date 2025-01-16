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
    let AQI: Double
    let components: [Pollutant:Double]
}

extension TimePollutionModel {
    var primaryPollutant: (name: Pollutant, value: Double) {
        let maxValue = components.values.max()
        let primaryPollutantName = components.first(where: { $1 == maxValue })?.key
        return (name: primaryPollutantName ?? .co, value: maxValue ?? 0)
    }
}

enum Pollutant: String {
    case co
    case no2
    case o3
    case so2
    case pm2_5
    case pm10
    case nh3
    case no
    
    var unicodeName: String {
        switch self {
        case .co:
            "CO"
        case .no2:
            "NO\(kUnicodeSubscriptTwo)"
        case .o3:
            "O\(kUnicodeSubscriptThree)"
        case .so2:
            "SO\(kUnicodeSubscriptTwo)"
        case .pm2_5:
            "PM\(kUnicodeSubscriptTwo).\(kUnicodeSubscriptFive)"
        case .pm10:
            "PM\(kUnicodeSubscriptOne)\(kUnicodeSubscriptZero)"
        case .nh3:
            "NH\(kUnicodeSubscriptThree)"
        case .no:
            "NO"
        }
    }
    
    var image: ImageResource {
        switch self {
        case .co: .coMol
        case .no2: .no2Mol
        case .o3: .o3Mol
        case .so2: .so2Mol
        case .nh3: .nh3Mol
        default: .coMol
        }
    }
}
