//
//  ContentView.swift
//  Beehives
//
//  Created by Yuri Gerasimchuk on 06.04.2023.
//

import SwiftUI

struct ContentView: View {
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

struct AddLocation: View {
    @EnvironmentObject var appData: ApplicationData
    @Environment(\.dismiss) var dismiss
    @State private var locationName = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Location Name", text: $locationName)
                    .textFieldStyle(.roundedBorder)
                Button("Save") {
                    let newLocation = Location(name: locationName, beehives: [])
                    appData.saveLocation(item: newLocation)
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                Spacer()
            }
            .padding()
            .toolbar {
                Button("Close") {
                    dismiss()
                }
            }
        }
    }
}


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

struct AddBeehive: View {
    var location: Location
    @EnvironmentObject var appData: ApplicationData
    @Environment(\.dismiss) var dismiss
    @State private var beehiveName = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Beehive Name", text: $beehiveName)
                    .textFieldStyle(.roundedBorder)
                Button("Save") {
                    let newBeehive = Beehive(name: beehiveName, age: 1, notes: [])
                    appData.saveBeehive(in: location, for: newBeehive)
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                Spacer()
            }
            .padding()
            .toolbar {
                Button("Close") {
                    dismiss()
                }
            }
        }
    }
}

struct NotesView: View {
    @EnvironmentObject var appData: ApplicationData
    var beehive: Beehive
    var location: Location
    @State private var showSheet = false
    @State private var id = UUID()
    
    var body: some View {
        List {
            ForEach(beehive.notes) { note in
                Text(note.content)
                    .swipeActions {
                        Button(role: .destructive) {
                            appData.removeNote(in: location, for: beehive, note: note)
                        } label: {
                            Image(systemName: "trash")
                        }
                    }
            }
        }
        .id(id)
        .navigationTitle(beehive.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button("Add") {
                showSheet = true
            }
        }
        .sheet(isPresented: $showSheet) {
            AddNote(location: location, beehive: beehive)
        }
    }
}

struct AddNote: View {
    var location: Location
    var beehive: Beehive
    @EnvironmentObject var appData: ApplicationData
    @Environment(\.dismiss) var dismiss
    @State private var noteName = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Notes Name", text: $noteName)
                    .textFieldStyle(.roundedBorder)
                Button("Save") {
                    let newNote = Note(content: noteName)
                    appData.saveNote(in: location, for: beehive, note: newNote)
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                Spacer()
            }
            .padding()
            .toolbar {
                Button("Close") {
                    dismiss()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ApplicationData())
    }
}
