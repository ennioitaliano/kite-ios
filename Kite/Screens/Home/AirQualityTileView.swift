//
//  AirQualityTileView.swift
//  Kite
//
//  Created by Ennio Italiano on 17/01/25.
//

import SwiftUI

struct AirQualityTileView: View {
    @Environment(HomeViewModel.self) private var viewModel
    @State var airQualityIndex: AirQualityIndex
    
    init(AQI: AirQualityIndex) {
        self.airQualityIndex = AQI
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Air Quality is currently".uppercased())
                .fontDesign(.rounded)
                .font(.system(size: 10))
                .foregroundStyle(Color.gray)
            Text(airQualityIndex.string.uppercased())
                .fontDesign(.rounded)
                .font(.system(size: 45))
                .padding(.bottom)
            if let comparisonSentence = viewModel.comparisonSentence {
                Text(comparisonSentence)
                    .fontDesign(.rounded)
                    .font(.system(size: 16))
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
        }
        .foregroundStyle(.white)
        .padding(.vertical, 32)
        .padding(.horizontal, 40)
        .frame(maxWidth: .infinity)
        .background(.black.gradient)
        .clipShape(.rect(cornerRadius: 20))
        .shadow(color: airQualityIndex.color, radius: 3)
    }
}

#Preview {
    @Previewable @State var airQualityIndex: AirQualityIndex = .good
    AirQualityTileView(AQI: airQualityIndex)
}
