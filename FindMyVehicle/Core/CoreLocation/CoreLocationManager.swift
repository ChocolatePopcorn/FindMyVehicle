//
//  CoreLocationManager.swift
//  FindMyVehicle
//
//  Created by ndyyy on 22/12/23.
//

import Foundation
import CoreLocation


class CoreLocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    @Published var location = CLLocationCoordinate2D()
    @Published var heading: CLHeading?
    
    static let shared = CoreLocationManager()
    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.last.map {
            location = $0.coordinate
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        guard newHeading.headingAccuracy >= 0 else {return}
        heading = newHeading
    }
    
    func stopHeading() {
        locationManager.stopUpdatingHeading()
    }
    
    func stopLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    func startHeading() {
        locationManager.startUpdatingHeading()
    }
    
    func startLocation() {
        locationManager.startUpdatingLocation()
    }
}
