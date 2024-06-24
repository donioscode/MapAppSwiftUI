//
//  MapAppSwiftUIApp.swift
//  MapAppSwiftUI
//
//  Created by doniyor normuxammedov on 23/06/24.
//

import SwiftUI

@main
struct MapAppSwiftUIApp: App {
    
    @StateObject private var vm = LocationsViewModel()

    
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(vm)
        }
    }
}
