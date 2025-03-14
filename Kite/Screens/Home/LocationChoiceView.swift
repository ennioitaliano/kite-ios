//
//  LocationChoiceView.swift
//  Kite
//
//  Created by Ennio Italiano on 14/03/25.
//

import CoreLocation
import SwiftUI

struct LocationChoiceView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(HomeViewModel.self) private var homeViewModel
    @State private var result: String?
    @Binding var locationSearchText: String

    var body: some View {
        VStack {
            locationSearchField
            List {
                if let result {
                    Button(result, systemImage: result == "Teolo, Italy" ? "location.fill" : "") {
                        locationSearchText = result
                        dismiss()
                    }
                    .foregroundStyle(.white)
                }
            }
            .listStyle(.plain)
            .scrollIndicators(.hidden)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .task {
            await homeViewModel.getPlacemark(for: locationSearchText)
            if let placemark = homeViewModel.placemark,
               let locality = placemark.locality,
               let country = placemark.country {
                result = ("\(locality), \(country)")
            }
        }
    }

    private var locationSearchField: some View {
        HStack(spacing: 12) {
            searchIcon
            searchField
            clearButton
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background {
            Color.black.brightness(0.25)
                .clipShape(.rect(cornerRadius: 10))
        }
        .padding([.top, .horizontal])
        .padding(.bottom, 6)
    }

    private var searchIcon: some View {
        Image(systemName: "magnifyingglass")
            .foregroundStyle(.gray)
    }

    private var searchField: some View {
        TextField("Search location", text: $locationSearchText)
            .autocorrectionDisabled()
            .frame(maxWidth: .infinity)
            .onSubmit {
                Task {
                    await homeViewModel.getPlacemark(for: locationSearchText)
                    if let placemark = homeViewModel.placemark,
                       let locality = placemark.locality,
                       let country = placemark.country {
                        result = ("\(locality), \(country)")
                    }
                }
            }
    }

    private var clearButton: some View {
        Button {
            locationSearchText = ""
            result = nil
        } label: {
            Image(systemName: "xmark.circle.fill")
                .foregroundStyle(.gray)
        }
        .opacity(locationSearchText.isEmpty ? 0 : 1)
    }
}

#Preview {
    LocationChoiceView(locationSearchText: .constant("Teolo, Italy"))
}
