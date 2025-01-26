//
//  PollutantTileView.swift
//  Kite
//
//  Created by Ennio Italiano on 23/12/24.
//

import SwiftUI

struct PollutantTileView: View {
    let pollutant: Pollutant
    let quantity: Double
        
    var body: some View {
        ZStack {
            pollutantImage
            blackLayer
            pollutantText
        }
        .frame(height: 175)
        .background(Color.black.gradient.opacity(0.85))
        .clipShape(.rect(cornerRadius: 20))
    }
    
    private var pollutantImage: some View {
        Image(pollutant.image)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: 150, maxHeight: 100)
            .offset(y: -10)
            .saturation(0)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
    }
    
    private var blackLayer: some View {
        Color.black.opacity(0.45)
    }
    
    private var pollutantText: some View {
        VStack(spacing: 10) {
            pollutantTitle
            pollutantDescription
        }
        .foregroundStyle(Color.white)
        .padding()
    }
    
    private var pollutantTitle: some View {
        Text(pollutant.unicodeName)
            .fontDesign(.rounded)
            .font(.system(size: 45))
    }
    
    private var pollutantDescription: some View {
        Text("\(quantity.formatted()) μg/m3")
            .monospaced()
            .font(.system(size: 16))
            .multilineTextAlignment(.center)
    }
}

#Preview {
    PollutantTileView(pollutant: .no2, quantity: 3)
}
