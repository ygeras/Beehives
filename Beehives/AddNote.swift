//
//  AddNote.swift
//  Beehives
//
//  Created by Yuri Gerasimchuk on 06.04.2023.
//

import SwiftUI

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

struct AddNote_Previews: PreviewProvider {
    static var previews: some View {
        AddNote(location: ApplicationData.mockData[0], beehive: ApplicationData.mockData[0].beehives[0])
            .environmentObject(ApplicationData())
    }
}
