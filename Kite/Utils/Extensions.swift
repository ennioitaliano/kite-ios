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
    func withSubscript(_ subscriptText: String?, baseFontSize: CGFloat = 17) -> AttributedString {
        var mainText = AttributedString(self)
        mainText.font = .system(size: baseFontSize)
        guard let subscriptText else { return mainText }
        var subText = AttributedString(subscriptText)
        subText.font = .system(size: baseFontSize * 0.7)
        subText.baselineOffset = -baseFontSize * 0.2
        mainText.append(subText)
        return mainText
    }
    
    func withSuperscript(_ superscriptText: String?, baseFontSize: CGFloat = 17) -> AttributedString {
        var mainText = AttributedString(self)
        mainText.font = .system(size: baseFontSize)
        guard let superscriptText else { return mainText }
        var superText = AttributedString(superscriptText)
        superText.font = .system(size: baseFontSize * 0.7)
        superText.baselineOffset = -baseFontSize * -0.3
        mainText.append(superText)
        return mainText
    }
}

