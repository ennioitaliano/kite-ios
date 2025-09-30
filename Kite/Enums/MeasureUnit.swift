//
//  MeasureUnit.swift
//  Kite
//
//  Created by Ennio Italiano on 28/09/25.
//

import Foundation

enum MeasureUnit {
    case ugm3
    case ppb
}

extension MeasureUnit {
    func formattedString(baseFontSize: CGFloat) -> AttributedString {
        switch self {
        case .ugm3: kMicrogramsCubicMeter.baselineOffset(
            type: .superscriptOffset,
            text: kCubicPower,
            baseFontSize: baseFontSize
        )
        default: AttributedString(kPartsPerBillion)
        }
    }
}
