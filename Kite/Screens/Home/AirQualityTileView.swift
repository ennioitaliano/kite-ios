//
//  AirQualityTileView.swift
//  Kite
//
//  Created by Ennio Italiano on 17/01/25.
//

import SwiftUI

struct AirQualityTileView: View {
    let isItalicOn: Bool
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.45)
            VStack(spacing: 0) {
                Text("Air Quality is currently".uppercased())
                    .font(.system(size: 10))
                    .foregroundStyle(Color.gray)
                Text("Good".uppercased())
                    .fontDesign(.monospaced)
                    .font(.system(size: 45))
                    .padding(.bottom)
                    .italic(isItalicOn)
                Text("Better than yesterday at this time.")
                    .font(.system(size: 16))
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
            .foregroundStyle(.white)
            .padding(.vertical, 32)
            .padding(.horizontal, 40)
            .frame(maxWidth: .infinity)
        }
        .background(.black.gradient.opacity(0.85))
        .clipShape(.rect(cornerRadius: 20))
    }
}

#Preview {
    AirQualityTileView(isItalicOn: false)
}
