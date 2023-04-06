//
//  AddBeehive.swift
//  Beehives
//
//  Created by Yuri Gerasimchuk on 06.04.2023.
//

import SwiftUI


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

struct AddBeehive_Previews: PreviewProvider {
    static var previews: some View {
        AddBeehive(location: ApplicationData.mockData[0])
            .environmentObject(ApplicationData())
    }
}
