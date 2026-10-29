# OWAirPollution

Local Swift package containing Kite's OpenWeather Air Pollution API integration:
current conditions, historical data, forecasts, response decoding, and models.
Kite depends on this package through `Kite.xcodeproj`; it is maintained alongside
the app and does not require a separate repository or release.

## Configuration and use

The app supplies the API key. Configure the client once before requesting data:

```swift
import CoreLocation
import OWAirPollution

try AirPollutionClient.configure(apiKey: "YOUR_OPENWEATHER_API_KEY")
let client = try AirPollutionClient.getAirPollutionClient()
let location = CLLocation(latitude: 45.44, longitude: 12.32)
let pollution = try await client.getCurrent(for: location)
```

The key is stored in memory for the lifetime of the client. The package does not
include credentials; see the root README for Kite's local configuration.

## Dependencies

- Alamofire for HTTP requests.
- swift-dependencies for dependency injection.
- CommonLogging for logging.

## Source

Imported from `openweather-airpollution-spm`, branch `feature/completed-package`,
commit `f32bde0b1d28e4ba4b3f05296d91e8398c987f12`. Local adjustments use the public
`CoreLocation` module in place of `_LocationEssentials`, explicitly import the
logging dependency, and match `LocalizedError.errorDescription`'s optional type.
