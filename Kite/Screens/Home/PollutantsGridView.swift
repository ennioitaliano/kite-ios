//
//  PollutantsGridView.swift
//  Kite
//
//  Created by Ennio Italiano on 11/01/25.
//

import SwiftUI

struct PollutantsStackView: View {
    let pollutants: [Pollutant:Double]
    
    var body: some View {
        LazyVStack(spacing: 10) {
//            Text("Pollutants".uppercased())
//                .fontDesign(.rounded)
//                .font(.system(size: 10))
//                .foregroundStyle(Color.gray)
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .padding(.leading)
            ForEach(pollutants.sorted(by: { $0.value > $1.value }), id: \.key) { pollutant in
                PollutantRowView(pollutant: pollutant.key, quantity: pollutant.value)
            }
        }
    }
}

#Preview {
    PollutantsStackView(pollutants: [.co: 0.1, .no2: 0.2, .o3: 0.3, .pm10: 0.4, .pm2_5: 0.5, .so2: 0.6])
}
