//
//  PollutantDetailView.swift
//  Kite
//
//  Created by Ennio Italiano on 16/05/25.
//

import OWAirPollution
import SwiftUI

struct PollutantDetailView: View {
    private let pollutant: Pollutant
    private let quantity: Double

    init(
        _ pollutant: Pollutant,
        quantity: Double
    ) {
        self.pollutant = pollutant
        self.quantity = quantity
    }

    var body: some View {
        VStack {
            pollutantTitle
            pollutantImageView
            pollutantDescription
        }
        .padding(.horizontal)
        .padding(.vertical, 32)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var pollutantTitle: some View {
        VStack(spacing: 3) {
            Text(pollutant.formattedFormula(baseFontSize: 50))
                .fontDesign(.rounded)
                .font(.system(size: 50))
                .bold()
            Text(pollutant.completeName)
                .font(.system(size: 25))
                .foregroundStyle(Color(UIColor.secondaryLabel))
        }
    }

    private var pollutantDescription: some View {
        HStack(spacing: 3) {
            Text("\(quantity.formatted(.number.precision(.fractionLength(1))))")
                .font(.system(size: 35, weight: .light, design: .monospaced))
            Text(pollutant.measureUnit.formattedString(baseFontSize: 28))
                .font(.system(size: 28, design: .monospaced))
                .foregroundStyle(Color(UIColor.secondaryLabel))
        }
    }

    private var pollutantImageView: some View {
        PollutantImageView(
            pollutant,
            fontSize: 100
        )
        .frame(maxHeight: .infinity)
    }
}

#Preview {
    PollutantDetailView(.co, quantity: 12.6)
}
