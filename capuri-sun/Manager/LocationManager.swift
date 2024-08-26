//
//  LocationManager.swift
//  capuri-sun
//
//  Created by 조세연 on 6/17/24.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation?
    @Published var address: String = "주소를 가져오는 중..."
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
    }
    
    func getCurrentLocation(completion: @escaping (CLLocation?) -> Void) {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.locationManager.stopUpdatingLocation()
                completion(self.locationManager.location)
            }
        } else {
            completion(nil)
        }
    }
    
    func reverseGeocode(_ location: CLLocation, completion: @escaping (String) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print(error.localizedDescription)
                completion("주소를 찾을 수 없습니다.")
                return
            }
            
            if let placemark = placemarks?.first {
                
                let locality = placemark.locality == nil ? placemark.administrativeArea : placemark.locality
                let address = "\(locality ?? ""), \(placemark.subLocality ?? "")"
                completion(address)
                
            } else {
                completion("주소를 찾을 수 없습니다.")
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.location = location
            reverseGeocode(location) { address in
                self.address = address
            }
        }
    }
}
