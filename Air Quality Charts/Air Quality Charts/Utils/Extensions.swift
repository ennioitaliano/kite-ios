//
//  Extensions.swift
//  Air Quality Charts
//
//  Created by Ennio Italiano on 16/05/24.
//

import CoreLocation
import Foundation

extension CLPlacemark {
    var APIString: String? {
        var components: [String?] = [
            self.locality,
            self.isoCountryCode
        ]

        if self.isoCountryCode == "US" {
            components[1] = self.administrativeArea
        }
        
        return components.compactMap { $0 }.joined(separator: ",")
    }

    var APIStringZip: String? {
        let components: [String?] = [
            self.postalCode,
            self.isoCountryCode
        ]
        
        return components.compactMap { $0 }.joined(separator: ",")
    }
}
