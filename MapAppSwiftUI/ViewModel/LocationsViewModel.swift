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
    
    // Show location detail via sheet
    @Published var sheetLocation: Location? = nil
    
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
    
    func nextButtonPressed() {
        // Get the current Index
        let currentIndex = locations.firstIndex { location in
            return location == maplocation
        }
        guard let currentIndex = locations.firstIndex(where: {$0 == maplocation}) else {
            print("Could not find current index in location array! Should never happen.")
            return
        }
           // Check if the currentIndex valid
        
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            // Next index is Not valid
            // Restart from 0
            
            guard let firstlocation = locations.first else { return }
            showNextLocation(location: firstlocation)
            return
        }
        
        
        // Next index Is valid
        
        let nextLocations = locations[nextIndex]
        showNextLocation(location: nextLocations)
    }
}
