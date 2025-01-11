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

//#Preview {
//    PollutantsGridView()
//}
