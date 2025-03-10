//
//  KiteApp.swift
//  Kite
//
//  Created by Ennio Italiano on 09/05/24.
//

import SwiftUI

@main
struct KiteApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .preferredColorScheme(.dark)
        }
    }
}
