# Kite - Air Quality App for iOS

Kite is a SwiftUI-powered iOS application designed to provide real-time air quality monitoring and insights. With a clean and intuitive user interface, Kite helps users stay informed about air quality levels and pollutants in their area and make healthier lifestyle decisions.

## Features

- **Real-Time Air Quality Data**: Get up-to-date air quality information from [OpenWeather](https://openweathermap.org/api/air-pollution) for your current location or any location worldwide.
- **SwiftUI Design**: Built with SwiftUI for a seamless and modern user experience.

## Screenshots

<img src="https://github.com/user-attachments/assets/77cccf52-7978-4f1c-b5a8-69f0966dfc17" width="300">

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/ennioitaliano/kite-ios.git
   ```
2. Create `Kite/Utils/Secrets.swift` with your OpenWeather API key:
   ```swift
   enum Secrets {
       static let APIKey = "YOUR_OPENWEATHER_API_KEY"
   }
   ```
   This file is ignored by Git. Do not commit your API key.
3. Open the project in Xcode:
   ```bash
   cd kite-ios
   open Kite.xcodeproj
   ```
4. Build and run the app on a simulator or connected device.

The OpenWeather client is included as a local Swift package in
[`Packages/OWAirPollution`](Packages/OWAirPollution). Xcode resolves its external
dependencies automatically; no separate checkout of the client is needed.

## Requirements

- iOS 18.0 or later
- Xcode 27.1 (verified; older versions have not been checked)
