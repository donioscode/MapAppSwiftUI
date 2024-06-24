//
//  LocationsView.swift
//  MapAppSwiftUI
//
//  Created by doniyor normuxammedov on 23/06/24.
//

import SwiftUI
import MapKit



struct LocationsView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel

    @State private var mapRegion: MKCoordinateRegion =
    MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 41.311081, longitude: 69.240562),
        span:MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1 ))
    
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $vm.mapRegion)
                .ignoresSafeArea()
            
            VStack(spacing:0) {
                
                header
                .padding()
                
                Spacer()
            }
            
        }
    }
}

#Preview {
    LocationsView()
        .environmentObject(LocationsViewModel())
}

extension LocationsView {
    private var header: some View {
        VStack {
            Button(action: {
                vm.toggleLocationsList()
            }, label: {
                Text(vm.maplocation.name+", "+vm.maplocation.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .animation(.none, value: vm.maplocation)
                    .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.title2)
                            .foregroundColor(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees: vm.showLocationsList ? 180 : 0))
                    }
            })
            if vm.showLocationsList {
                LocationsListView()
            }
           
        }
        .background(.thinMaterial)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 20,x: 0,y: 15)
    }
}
