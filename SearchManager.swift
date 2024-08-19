//
//  SearchManager.swift
//  StudyWithMe
//
//  Created by Deborah Mok on 4/19/24.
//

import Foundation
import CoreLocation
import MapKit

class SearchManager: NSObject, ObservableObject {
    //Published properties to track location and region changes
    @Published var location: CLLocation?
    @Published var region: MKCoordinateRegion = MKCoordinateRegion.defaultRegion()
    
    //CLLocationManager instance for managing location updates
    private let searchManager = CLLocationManager ()
    
    //Initializer for SearchManager
    override init() {
        super.init()
        //Configuring CLLocationManager properties
        searchManager.desiredAccuracy = kCLLocationAccuracyBest
        searchManager.distanceFilter = kCLDistanceFilterNone
        //Requesting user authorization for location access
        searchManager.requestAlwaysAuthorization()
        //Starting location updates
        searchManager.startUpdatingLocation()
        //Setting the delegate to handle location updates
        searchManager.delegate = self
    }
}

extension SearchManager: CLLocationManagerDelegate {
    //Delegate method called when the location manager updates the location
    func searchManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //Extracting the latest location from the array of locations
        guard let location = locations.last else { return }
        //Updating the location and region properties on the main thread
        DispatchQueue.main.async { [weak self] in
            //Updating the location propert
            self?.location = location
            //Updating the region property to center around the new location with a certain span
            self?.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 5000, longitudinalMeters: 5000)
        }
    }
}
