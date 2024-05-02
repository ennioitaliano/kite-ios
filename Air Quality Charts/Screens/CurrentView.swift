//
//  CurrentView.swift
//  Air Quality Charts
//
//  Created by Ennio Italiano on 02/05/24.
//

import Charts
import SwiftUI

struct HomeView: View {
    var data: [MonthlyHoursOfSunshine] = [
        MonthlyHoursOfSunshine(month: 1, hoursOfSunshine: 74),
        MonthlyHoursOfSunshine(month: 2, hoursOfSunshine: 99),
        MonthlyHoursOfSunshine(month: 4, hoursOfSunshine: 97),
        // ...
        MonthlyHoursOfSunshine(month: 12, hoursOfSunshine: 62)
    ]

    var body: some View {
        VStack(spacing: 0) {
            header
            ScrollView {
                VStack {
                    mainInfo
                    charts
                }
                .padding()
            }
            .background(.white)
        }
    }

    private var header: some View {
        HStack {
            Button {

            } label: {
                Image(systemName: "list.bullet.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
            }
            VStack {
                Text("Current Location")
                    .font(.headline)
                Text("Teolo")
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity)

            Button {

            } label: {
                Image(systemName: "gear.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
            }
        }
        .padding()
    }

    private var mainInfo: some View {
        VStack {
            currentAQ
            HStack {
                primaryPollutant
                yesterdayComparison
            }
        }
    }

    private var currentAQ: some View {
        VStack {
//            Image(systemName: "wind")
//                .resizable()
//                .scaledToFit()
//                .frame(width: 80, height: 80)
//                .foregroundStyle(.white.gradient)
            Text("5")
                .font(.largeTitle)
                .padding()
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .stroke(.black.gradient, lineWidth: 3)
                }
            Text("Good")
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.blue.gradient)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }

    private var primaryPollutant: some View {
        VStack {
            Text("O3")
                .padding()
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .stroke(.black.gradient, lineWidth: 3)
                }
            Text("Primary pollutant")
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.blue.gradient)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }

    private var yesterdayComparison: some View {
        VStack {
            Text("Air quality will be better tomorrow")
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.blue.gradient)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            Text("Air quality is better than yesterday")
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.blue.gradient)
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
    }

    private var charts: some View {
        VStack {
            AQChart
            pollutantsChart
        }
    }

    private var AQChart: some View {
        VStack {
            HStack {
                Text("Air Quality Index")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Button {

                } label: {
                    HStack {
                        Text("Last month")
                        Image(systemName: "calendar.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
                }
            }
            Chart(data) {
                LineMark(
                    x: .value("Month", $0.date),
                    y: .value("Hours of Sunshine", $0.hoursOfSunshine)
                )
            }
        }
        .padding()
    }

    private var pollutantsChart: some View {
        VStack {
            HStack {
                Text("Pollutants")
                    .frame(maxWidth: .infinity, alignment: .leading)
                Button {

                } label: {
                    HStack {
                        Text("Last month")
                        Image(systemName: "calendar.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                    }
                }
            }
            Chart(data) {
                LineMark(
                    x: .value("Month", $0.date),
                    y: .value("Hours of Sunshine", $0.hoursOfSunshine)
                )
            }
            VStack {
                HStack {
                    Group {
                        Text("co")
                        Text("nh3")
                        Text("no")
                        Text("no2")
                    }
                    .font(.callout)
                    .frame(maxWidth: .infinity)
                    .padding(7)
                    .background(.gray.gradient)
                    .clipShape(RoundedRectangle(cornerRadius: 7))
                }
                HStack {
                    Group {
                        Text("o3")
                        Text("pm10")
                        Text("pm2.5")
                        Text("so2")
                    }
                    .font(.callout)

                    .frame(maxWidth: .infinity)
                    .padding(7)
                    .background(.gray.gradient)
                    .clipShape(RoundedRectangle(cornerRadius: 7))
                }
                Text("Long press on a pollutant to know more")
                    .font(.footnote)
            }
        }
        .padding()
    }
}

#Preview {
    HomeView()
}

struct MonthlyHoursOfSunshine: Identifiable {
    var id = UUID()
    var date: Date
    var hoursOfSunshine: Double


    init(month: Int, hoursOfSunshine: Double) {
        let calendar = Calendar.autoupdatingCurrent
        self.date = calendar.date(from: DateComponents(year: 2020, month: month))!
        self.hoursOfSunshine = hoursOfSunshine
    }
}
