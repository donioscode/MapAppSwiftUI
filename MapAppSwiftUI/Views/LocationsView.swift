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
    
    let maxWidthForIpad: CGFloat = 700

    @State private var mapRegion: MKCoordinateRegion =
    MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 41.311081, longitude: 69.240562),
        span:MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1 ))
    
    
    var body: some View {
        ZStack {
              mapLayer
                .ignoresSafeArea()
            
            VStack(spacing:0) {
                header
                   .padding()
                   .frame(maxWidth: maxWidthForIpad)
                Spacer()
                locationsPreviewStack
            }
        }
        .sheet(item: $vm.sheetLocation, onDismiss: nil) { location in
            LocationDetailView(location: location)
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
    
    private var mapLayer: some View {
        Map(
            coordinateRegion: $vm.mapRegion,
            annotationItems: vm.locations,
            annotationContent: { location in
                MapAnnotation(coordinate: location.coordinates) {
                    LocationMapAnnotationView()
                        .scaleEffect(vm.maplocation == location ? 1 : 0.7)
                        .shadow(radius: 10)
                        .onTapGesture {
                            vm.showNextLocation(location: location)
                        }
                }
            })
    }
    
    private var locationsPreviewStack: some View {
        ZStack {
            ForEach(vm.locations) { location in
                if vm.maplocation == location {
                    LocationPreviewView(location: location)
                        .shadow(color: Color.black.opacity(0.3), radius: 20)
                        .padding()
                        .frame(maxWidth: maxWidthForIpad)
                        .frame(maxWidth: .infinity)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)))
                }
               
            }
        }
    }
}
