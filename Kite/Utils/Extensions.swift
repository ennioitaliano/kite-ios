//
//  Extensions.swift
//  Kite
//
//  Created by Ennio Italiano on 16/05/24.
//

import CoreLocation
import Foundation

extension String {
    func baselineOffset(
        type: BaselineOffsetType,
        text: String?,
        baseFontSize: CGFloat
    ) -> AttributedString {
        var mainText = AttributedString(self)
        mainText.font = .system(size: baseFontSize)
        guard let text else { return mainText }
        var offsetText = AttributedString(text)
        offsetText.font = .system(size: baseFontSize * 0.6)
        offsetText.baselineOffset = -baseFontSize * (type == .subscriptOffset ? 0.1 : -0.3)
        mainText.append(offsetText)
        return mainText
    }
}

enum BaselineOffsetType {
    case subscriptOffset
    case superscriptOffset
}

extension Double {
    func convert(to measureUnit: MeasureUnit, with molecularWeight: Double?) -> Double {
        switch measureUnit {
        case .ppb:
            guard let molecularWeight else { return self }
            let absoluteZeroK: Double = 273.15
            let temperature: Double = 25
            let inverseUniversalGasLaw: Double = 12.187
            return (self * (absoluteZeroK + temperature)) / (inverseUniversalGasLaw * molecularWeight)
        default: return self
        }
    }
}

extension [String: Double] {
    func toModel() -> [Pollutant: Double] {
        reduce(into: [:]) { result, element in
            guard let pollutant = Pollutant(rawValue: element.key) else { return }
            result[pollutant] = element.value
        }
    }
}
