//
//  Pollutant.swift
//  Kite
//
//  Created by Ennio Italiano on 22/01/25.
//

import SwiftUI

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
}
