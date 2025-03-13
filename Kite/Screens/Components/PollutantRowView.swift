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
            pollutantDescription
        }
        .frame(maxWidth: .infinity)
        .padding()
        .foregroundStyle(Color.white)
        .background(Color.black.brightness(0.1))
        .clipShape(.rect(cornerRadius: 15))
        .shadow(radius: 1)
    }

    @ViewBuilder
    private var pollutantImageView: some View {
        if let pollutantImage = pollutant.image {
            Image(pollutantImage)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 50, maxHeight: 50)
        } else {
            Image(systemName: pollutant == .pm10 ? "aqi.medium" : "aqi.low")
                .foregroundStyle(.gray)
                .font(.system(size: 25))
                .fontWeight(.black)
                .frame(width: 50)
        }
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

    private var pollutantDescription: some View {
        HStack(spacing: 3) {
            Text("\(quantity.formatted(.number.precision(.fractionLength(1))))")
                .monospaced()
                .font(.system(size: 20))
                .fontWeight(.light)
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
