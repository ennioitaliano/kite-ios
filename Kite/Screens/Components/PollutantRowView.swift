//
//  PollutantRowView.swift
//  Kite
//
//  Created by Ennio Italiano on 13/02/25.
//

import OWAirPollution
import SwiftUI

struct PollutantRowView: View {
    @Environment(\.colorScheme) private var colorScheme
    let pollutant: Pollutant
    let quantity: Double

    var body: some View {
        HStack(spacing: 12) {
            pollutantImageView
            pollutantTitle
            pollutantQuantity
        }
        .frame(maxWidth: .infinity)
        .padding()
        .foregroundStyle(Color(UIColor.label))
        .background(Color(colorScheme == .light ? UIColor.systemBackground : UIColor.secondarySystemBackground))
        .conditionalModifier { view in
            if .iOS26 {
                view.clipShape(.capsule)
            } else {
                view.clipShape(.rect(cornerRadius: 15))
            }
        }
        .shadow(radius: colorScheme == .light ? 0.5 : 1)
    }

    private var pollutantImageView: some View {
        PollutantImageView(
            pollutant,
            fontSize: 25
        )
    }

    private var pollutantTitle: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(pollutant.formattedFormula(baseFontSize: 20))
                .fontDesign(.rounded)
                .font(.system(size: 20))
                .bold()
            Text(pollutant.completeName)
                .font(.system(size: 12))
                .foregroundStyle(Color(UIColor.secondaryLabel))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var pollutantQuantity: some View {
        HStack(spacing: 3) {
            Text("\(quantity.formatted(.number.precision(.fractionLength(1))))")
                .font(.system(size: 20, weight: .light, design: .monospaced))
            Text(pollutant.measureUnit.formattedString(baseFontSize: 16))
                .font(.system(size: 16, design: .monospaced))
                .foregroundStyle(Color(UIColor.secondaryLabel))
        }
    }
}

#Preview {
    PollutantRowView(pollutant: .no2, quantity: 3)
        .padding()
}
