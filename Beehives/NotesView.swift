//
//  NotesView.swift
//  Beehives
//
//  Created by Yuri Gerasimchuk on 06.04.2023.
//

import SwiftUI

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

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            NotesView(beehive: ApplicationData.mockData[0].beehives[0], location: ApplicationData.mockData[0])
                .environmentObject(ApplicationData())
        }
    }
}
