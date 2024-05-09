//
//  GeocodingModel.swift
//  Air Quality Charts
//
//  Created by Ennio Italiano on 09/05/24.
//

import Foundation

struct GeocodingModel {
    let name: String
    let localNames: LocalNamesModel
    let latitude: Double
    let longitude: Double
    let country: String
    let state: String?
}

struct LocalNamesModel {
    let featureName: String
    let ASCIIName: String
    let italianName: String?
}
