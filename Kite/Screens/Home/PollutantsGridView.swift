//
//  PollutantsGridView.swift
//  Kite
//
//  Created by Ennio Italiano on 11/01/25.
//

import SwiftUI

struct PollutantsGridView: View {
    let pollutants: [Pollutant:Double]
    
    var body: some View {
        LazyVGrid(columns: .init(repeating: .init(.flexible()), count: 2), spacing: 10) {
            ForEach(pollutants.sorted(by: { $0.value > $1.value }), id: \.key) { pollutant in
                PollutantTileView(pollutant: pollutant.key, quantity: pollutant.value)
            }
        }
    }
}

#Preview {
    PollutantsGridView(pollutants: [.co: 0.1, .no2: 0.2, .o3: 0.3, .pm10: 0.4, .pm2_5: 0.5, .so2: 0.6])
}
