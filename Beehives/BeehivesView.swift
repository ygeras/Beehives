//
//  BeehivesView.swift
//  Beehives
//
//  Created by Yuri Gerasimchuk on 06.04.2023.
//

import SwiftUI

struct BeehivesView: View {
    @EnvironmentObject var appData: ApplicationData
    var location: Location
    @State private var showSheet = false
    @State private var id = UUID()
    
    var body: some View {
        List {
            ForEach(location.beehives) { beehive in
                NavigationLink(beehive.name) {
                    NotesView(beehive: beehive, location: location)
                }
                .swipeActions {
                    Button(role: .destructive) {
                        appData.removeBeehive(in: location, for: beehive)
                    } label: {
                        Image(systemName: "trash")
                    }
                }
            }
        }
        .id(id)
        .navigationTitle(location.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button("Add") {
                showSheet = true
            }
        }
        .sheet(isPresented: $showSheet) {
            AddBeehive(location: location)
        }
    }
}
struct BeehivesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            BeehivesView(location: ApplicationData.mockData[0])
                .environmentObject(ApplicationData())
        }
    }
}
