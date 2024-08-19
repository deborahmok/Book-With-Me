//
//  SearchResultsViewModel.swift
//  StudyWithMe
//
//  Created by Deborah Mok on 4/19/24.
//

import Foundation
import MapKit

@MainActor
class SearchResultsViewModel: ObservableObject {
    
    @Published var places = [PlaceViewModel]()
    
    func search(text: String, region: MKCoordinateRegion) {
        //making a search request with the provided text and region
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = text
        searchRequest.region = region
        
        let search = MKLocalSearch(request: searchRequest)
        
        search.start { response, error in
            guard let response = response else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            //if response works, map the response's mapItems to PlaceViewModels and assign them to places
            self.places = response.mapItems.map(PlaceViewModel.init)
        }
    }
}

//viewmodel for a place
struct PlaceViewModel: Identifiable {
    let id = UUID()
    private var mapItem: MKMapItem
    
    //init to create a PlaceViewModel from a MKMapItem
    init(mapItem: MKMapItem) {
        self.mapItem = mapItem
    }
    
    var name: String
    {
        //if it exsists, print
        mapItem.name ?? ""
    }
}
