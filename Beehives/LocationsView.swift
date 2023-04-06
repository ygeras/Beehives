//
//  LocationsView.swift
//  Beehives
//
//  Created by Yuri Gerasimchuk on 06.04.2023.
//

import SwiftUI

struct LocationsView: View {
    @EnvironmentObject var appData: ApplicationData
    @State private var showSheet = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(appData.locations) { location in
                    NavigationLink(location.name) {
                        BeehivesView(location: location)
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            appData.removeLocation(location)
                        } label: {
                            Image(systemName: "trash")
                        }
                        
                    }
                }
            }
            .navigationTitle("Locations")
            .toolbar {
                Button("Add") {
                    showSheet = true
                }
            }
            .sheet(isPresented: $showSheet) {
                AddLocation()
            }
        }
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .environmentObject(ApplicationData())
    }
}
