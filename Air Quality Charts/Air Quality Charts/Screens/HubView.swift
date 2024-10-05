//
//  HubView.swift
//  Air Quality Charts
//
//  Created by Ennio Italiano on 05/07/24.
//

import Inject
import SwiftUI

struct HubView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            Text("Analysis")
                .tabItem {
                    Label("Analysis", systemImage: "chart.pie")
                }
            Text("History")
                .tabItem {
                    Label("History", systemImage: "clock.arrow.circlepath")
                }
        }
    }
}

#Preview {
    HubView()
}
