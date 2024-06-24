//
//  LocationsViewModel.swift
//  MapAppSwiftUI
//
//  Created by doniyor normuxammedov on 23/06/24.
//

import Foundation
import SwiftUI
import MapKit

class LocationsViewModel: ObservableObject {
    
    // All loaded locations
    @Published var locations: [Location]
    
    // Current location on map
    @Published var maplocation: Location{
        didSet{
            updateMapRegion(location: maplocation)
        }
    }
    //Current region on map
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1 )
    
    //Show list of locatons
    @Published var showLocationsList: Bool = false
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
        self.maplocation = locations.first!
        self.updateMapRegion(location: locations.first!)
    }
    
    private func updateMapRegion(location: Location) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(
                center: location.coordinates,
                span: mapSpan)

        }
    }
    
     func toggleLocationsList() {
        withAnimation(.easeInOut){
            showLocationsList.toggle()
        }
    }
    
    func showNextLocation(location:Location) {
        withAnimation(.easeInOut){
            maplocation = location
            showLocationsList = false
        }
    }
}
