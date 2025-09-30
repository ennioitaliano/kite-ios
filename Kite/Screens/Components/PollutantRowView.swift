//
//  PollutantRowView.swift
//  Kite
//
//  Created by Ennio Italiano on 13/02/25.
//

import SwiftUI

struct PollutantRowView: View {
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
        .foregroundStyle(Color.white)
        .background(Color.black.brightness(0.1))
        .conditionalModifier { view in
            if .iOS26 {
                view.clipShape(.capsule)
            } else {
                view.clipShape(.rect(cornerRadius: 15))
            }
        }
        .shadow(radius: 1)
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
                .foregroundStyle(.gray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var pollutantQuantity: some View {
        HStack(spacing: 3) {
            Text("\(quantity.formatted(.number.precision(.fractionLength(1))))")
                .font(.system(size: 20, weight: .light, design: .monospaced))
            Text(pollutant.measureUnit.formattedString(baseFontSize: 16))
                .monospaced()
                .font(.system(size: 16))
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
    PollutantRowView(pollutant: .no2, quantity: 3)
        .padding()
}
