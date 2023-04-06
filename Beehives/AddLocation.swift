//
//  AddLocation.swift
//  Beehives
//
//  Created by Yuri Gerasimchuk on 06.04.2023.
//

import SwiftUI


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

struct AddLocation_Previews: PreviewProvider {
    static var previews: some View {
        AddLocation()
            .environmentObject(ApplicationData())
    }
}
