//
//  Pollutant.swift
//  Kite
//
//  Created by Ennio Italiano on 22/01/25.
//

import SwiftUI

// swiftlint: disable identifier_name
enum Pollutant: String {
    case co
    case no2
    case o3
    case so2
    case pm2_5
    case pm10
    case nh3
    case no

    private var moleculesNames: String {
        switch self {
        case .co: "CO"
        case .no, .no2: "NO"
        case .o3: "O"
        case .so2: "SO"
        case .pm2_5, .pm10: "PM"
        case .nh3: "NH"
        }
    }

    private var subscriptItems: String? {
        switch self {
        case .co, .no: nil
        case .no2: "2"
        case .o3: "3"
        case .so2: "2"
        case .pm2_5: "2.5"
        case .pm10: "10"
        case .nh3: "3"
        }
    }

    var completeName: String {
        switch self {
        case .co: "Carbon Monoxide"
        case .no2: "Nitrogen Dioxide"
        case .o3: "Ozone"
        case .so2: "Sulfur Dioxide"
        case .pm2_5: "Particulates < 2,5μm"
        case .pm10: "Particulates < 10μm"
        case .nh3: "Ammonia"
        case .no: "Nitric Oxide"
        }
    }

    func formattedFormula(baseFontSize: CGFloat) -> AttributedString {
        moleculesNames.withSubscript(subscriptItems, baseFontSize: baseFontSize)
    }

    var image: ImageResource? {
        switch self {
        case .co: .coMol
        case .no2: .no2Mol
        case .o3: .o3Mol
        case .so2: .so2Mol
        case .nh3: .nh3Mol
        case .no: .noMol
        default: nil
        }
    }

    var measureUnit: MeasureUnit {
        switch self {
        case .co, .no2, .o3, .so2: .ppb
        case .pm2_5, .pm10, .nh3, .no: .ugm3
        }
    }

    var molecularWeight: Double? {
        switch self {
        case .co: 28.01
        case .no2: 46.01
        case .o3: 48
        case .so2: 64.07
        default: nil
        }
    }
}

enum MeasureUnit: AttributedString {
    case ugm3
    case ppb

    var formattedString: AttributedString {
        switch self {
        case .ugm3:
            "μg/m".withSuperscript("3", baseFontSize: 16)
        default:
            rawValue
        }
    }
}
// swiftlint: enable identifier_name
