//
//  Extensions.swift
//  Kite
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

extension String {
    /// Returns an AttributedString with the provided subscript text appended in a subscript style.
    ///
    /// - Parameters:
    ///   - subscriptText: The text to display as a subscript.
    ///   - baseFontSize: The font size of the main text (default is 17).
    /// - Returns: An `AttributedString` combining the main text and the subscript.
    func withSubscript(_ subscriptText: String?, baseFontSize: CGFloat = 17) -> AttributedString {
        var mainText = AttributedString(self)
        mainText.font = .system(size: baseFontSize)
        
        guard let subscriptText else { return mainText }

        var subText = AttributedString(subscriptText)
        // Scale the font size for the subscript (e.g. 70% of the base font)
        subText.font = .system(size: baseFontSize * 0.7)
        // Adjust the baseline so the subscript appears lower than the main text
        subText.baselineOffset = -baseFontSize * 0.2
        
        mainText.append(subText)
        return mainText
    }
}

