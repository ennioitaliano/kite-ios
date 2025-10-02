//
//  PollutantImageView.swift
//  Kite
//
//  Created by Ennio Italiano on 28/09/25.
//

import OWAirPollution
import SwiftUI

struct PollutantImageView: View {

    private let pollutant: Pollutant
    private let fontSize: CGFloat
    private let maxWidth: CGFloat

    init(
        _ pollutant: Pollutant,
        fontSize: CGFloat
    ) {
        self.pollutant = pollutant
        self.fontSize = fontSize
        self.maxWidth = fontSize * 2
    }

    @ViewBuilder
    var body: some View {
        if let pollutantImage = pollutant.imageResource {
            Image(pollutantImage)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: maxWidth)
        } else {
            Image(systemName: pollutant == .pm10 ? "aqi.medium" : "aqi.low")
                .foregroundStyle(.gray)
                .font(.system(size: fontSize))
                .fontWeight(.black)
                .frame(width: maxWidth)
        }
    }
}
