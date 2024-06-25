//
//  MapViewModel.swift
//  UsersInfoApp
//
//  Created by Andres Cordón on 25/6/24.
//

import Foundation
import CoreLocation
import MapKit

class MapViewModel: ObservableObject {
    let city: String
    
    init(city: String) {
        self.city = city
    }
    
    func updateMapView(_ map: MKMapView) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(city) { placemarks, error in
            guard let placemark = placemarks?.first, let location = placemark.location else {
                if let error = error {
                    print("Geocoding error: \(error.localizedDescription)")
                }
                return
            }
            let coordinate = location.coordinate
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = self.city
            map.addAnnotation(annotation)
            map.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)), animated: true)
        }
    }
}
