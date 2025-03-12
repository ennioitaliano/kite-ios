//
//  KiteList.swift
//  Kite
//
//  Created by Ennio Italiano on 10/03/25.
//

import SwiftUI

struct KiteList<Content: View>: View {
    
    let content: Content
    
    init(@ViewBuilder _ content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        List {
            content
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .listSectionSeparator(.hidden)
        }
        .listStyle(.plain)
        .contentMargins(.top, 8)
        .contentMargins(.horizontal, 0)
        .contentMargins(.bottom, 0)
        .scrollIndicators(.hidden)
        .scrollContentBackground(.hidden)
    }
}
