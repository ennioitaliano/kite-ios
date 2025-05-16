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
        case .co: kMoleculeNameCO
        case .no, .no2: kMoleculeNameNO
        case .o3: kMoleculeNameO
        case .so2: kMoleculeNameSO
        case .pm2_5, .pm10: kMoleculeNamePM
        case .nh3: kMoleculeNameNH
        }
    }

    private var moleculesQuantities: String? {
        switch self {
        case .co, .no: nil
        case .no2, .so2: kMoleculeQuantity2
        case .o3, .nh3: kMoleculeQuantity3
        case .pm2_5: kMoleculeQuantity25
        case .pm10: kMoleculeQuantity10
        }
    }

    var completeName: String {
        switch self {
        case .co: kPollutantCompleteNameCO
        case .no2: kPollutantCompleteNameNO2
        case .o3: kPollutantCompleteNameO3
        case .so2: kPollutantCompleteNameSO2
        case .pm2_5: kPollutantCompleteNamePM25
        case .pm10: kPollutantCompleteNamePM10
        case .nh3: kPollutantCompleteNameNH3
        case .no: kPollutantCompleteNameNO
        }
    }

    func formattedFormula(baseFontSize: CGFloat) -> AttributedString {
        moleculesNames.baselineOffset(
            type: .subscriptOffset,
            text: moleculesQuantities,
            baseFontSize: baseFontSize
        )
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
        case .co: kMoleculeWeigthCO
        case .no2: kMoleculeWeigthNO2
        case .o3: kMoleculeWeigthO3
        case .so2: kMoleculeWeigthSO2
        default: nil
        }
    }
}

extension Pollutant: Identifiable {
    var id: String {
        rawValue
    }
}

enum MeasureUnit: AttributedString {
    case ugm3
    case ppb

    func formattedString(baseFontSize: CGFloat) -> AttributedString {
        switch self {
        case .ugm3: kMicrogramsCubicMeter.baselineOffset(
            type: .superscriptOffset,
            text: kCubicPower,
            baseFontSize: baseFontSize
        )
        default: rawValue
        }
    }
}
// swiftlint: enable identifier_name
