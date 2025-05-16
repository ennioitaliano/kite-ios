//
//  PollutantDetailView.swift
//  Kite
//
//  Created by Ennio Italiano on 16/05/25.
//

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
        .background(Color.black.brightness(0.1))
        .preferredColorScheme(.dark)
    }
    
    private var pollutantTitle: some View {
        VStack(spacing: 3) {
            Text(pollutant.formattedFormula(baseFontSize: 50))
                .fontDesign(.rounded)
                .font(.system(size: 50))
                .bold()
            Text(pollutant.completeName)
                .font(.system(size: 25))
                .foregroundStyle(.gray)
        }
    }

    private var pollutantDescription: some View {
        HStack(spacing: 3) {
            Text("\(quantity.formatted(.number.precision(.fractionLength(1))))")
                .monospaced()
                .font(.system(size: 35))
                .fontWeight(.light)
            Text(pollutant.measureUnit.formattedString(baseFontSize: 28))
                .monospaced()
                .font(.system(size: 28))
                .foregroundStyle(.gray)
        }
    }
    
    @ViewBuilder
    private var pollutantImageView: some View {
        Group {
            if let pollutantImage = pollutant.image {
                Image(pollutantImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 200)
            } else {
                Image(systemName: pollutant == .pm10 ? "aqi.medium" : "aqi.low")
                    .foregroundStyle(.gray)
                    .font(.system(size: 100))
                    .fontWeight(.black)
                    .frame(width: 200)
            }
        }
        .frame(maxHeight: .infinity)
    }
}

#Preview {
    PollutantDetailView(.co, quantity: 12.6)
}
