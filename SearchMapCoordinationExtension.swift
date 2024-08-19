//
//  SearchMapCoordinationExtension.swift
//  StudyWithMe
//
//  Created by Deborah Mok on 4/19/24.
//

import Foundation
import MapKit

extension MKCoordinateRegion {
    //Static method to create a default region
    static func defaultRegion() -> MKCoordinateRegion {
        //Creating a default region with a specific center and span
        MKCoordinateRegion(center: CLLocationCoordinate2D.init(latitude: 29.726819, longitude: -95.393692),
                           latitudinalMeters: 100, longitudinalMeters: 100)
    }
}
