//
//  LocationManager.swift
//  Air Quality Charts
//
//  Created by Ennio on 2024-10-05.
//

import CoreLocation
import Dependencies

@Observable
class LocationManager: NSObject, CLLocationManagerDelegate {
    @ObservationIgnored @Dependency(\.logger) private var logger

    let manager = CLLocationManager()
    private var location: CLLocationCoordinate2D?
    var locationPlacemark: CLPlacemark?
    var locationErrorAlertPresenting: Bool = false

    override init() {
        super.init()
        manager.delegate = self
    }

    func requestLocation() {
        manager.requestLocation()
    }

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        location = locations.first?.coordinate
        Task {
           await lookUpCurrentLocation()
        }
    }

    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: any Error
    ) {
        locationErrorAlertPresenting = true
    }

    func lookUpCurrentLocation() async {
        if let lastLocationCoords = self.location {
            let geocoder = CLGeocoder()

            let lastLocation = CLLocation(
                latitude: lastLocationCoords.latitude,
                longitude: lastLocationCoords.longitude
            )

            do {
                let placemarks = try await geocoder.reverseGeocodeLocation(lastLocation)
                locationPlacemark = placemarks.first
            } catch {
                logger.logError(.location, error.localizedDescription)
            }
        } else {
            logger.logError(.location, "Location not available")
        }
    }
}
