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
        HStack(spacing: 0) {
            pollutantTitle
                .frame(width: 100, alignment: .leading)
            Spacer()
            pollutantImage
                .frame(width: 50, alignment: .center)
            Spacer()
            pollutantDescription
                .frame(width: 175, alignment: .trailing)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .foregroundStyle(Color.white)
        .frame(height: 70)
        .background(Color.black.brightness(0.1))
        .clipShape(.rect(cornerRadius: 15))
        .shadow(radius: 1)
    }
    
    private var pollutantImage: some View {
        Image(pollutant.image)
            .resizable()
            .scaledToFit()
    }
    
    private var pollutantTitle: some View {
        Text(pollutant.unicodeName)
            .fontDesign(.rounded)
            .font(.system(size: 20))
            .bold()
    }
    
    private var pollutantDescription: some View {
        HStack(spacing: 5) {
            Text("\(quantity.formatted())")
                .monospaced()
                .font(.system(size: 20))
                .multilineTextAlignment(.center)
                .fontWeight(.light)
            Text("μg/m3")
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
