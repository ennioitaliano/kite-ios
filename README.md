# Kite

A SwiftUI app for checking a city's air quality, comparing it with the previous day, and exploring individual pollutants. Data comes from the [OpenWeather Air Pollution API](https://openweathermap.org/api/air-pollution).

<img src="https://github.com/user-attachments/assets/77cccf52-7978-4f1c-b5a8-69f0966dfc17" alt="Kite app screenshot" width="300">

## What it does

- **Search by city** and remember the last selected location between launches.
- **Check air quality at a glance** using OpenWeather's five-level index, from Good to Very Poor.
- **Compare with yesterday** to see whether the air quality category has improved, worsened, or stayed the same.
- **Inspect pollutants** with names, chemical formulas, concentrations, and a detail sheet with molecular illustrations where available.
- **Pull to refresh** and use the app in light or dark mode.

## How it's built

- **SwiftUI and MVVM:** [HomeView](Kite/Screens/Home/HomeView.swift) handles presentation and city search; the observable [HomeViewModel](Kite/Screens/Home/HomeViewModel.swift) loads data and prepares the comparison shown in the UI.
- **Swift concurrency:** current and historical readings are requested concurrently with `async`/`await` and a task group. UI state is updated on the main actor.
- **A local OpenWeather package:** [OWAirPollution](Packages/OWAirPollution) contains API requests, response decoding, and data models. Keeping it in this repository gives the integration its own module while allowing app and client changes to be maintained together.
- **Dependency injection and logging:** `swift-dependencies` supplies the API service and logger; Alamofire handles HTTP requests, and CommonLogging records failures.

## Run locally

### Requirements

- iOS 18.0 or later.
- Xcode 27.1, used to verify the simulator build. Older Xcode versions have not been checked.
- An internet connection and an OpenWeather API key with access to the [Air Pollution API](https://openweathermap.org/api/air-pollution).

### Setup

1. Clone the repository and enter its directory:

   ```bash
   git clone https://github.com/ennioitaliano/kite-ios.git
   cd kite-ios
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
   open Kite.xcodeproj
   ```

4. Let Xcode resolve package dependencies, select an iPhone simulator, and run the `Kite` scheme. Running on a physical device also requires configuring signing with your own development team.

OWAirPollution is included in the checkout; no separate client repository is needed. On first launch, Kite loads Venice. Use the city button to search for another location, tap a pollutant for its details, or pull down to refresh.
