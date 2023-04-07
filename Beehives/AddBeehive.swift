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
    @State private var population = 0
    @State private var numberOfQueens = 0
    @State private var queenType = "Type 1"
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.zeroSymbol  = ""
        return formatter
    }()
    
    let types = ["Type 1", "Type 2", "Type 3", "Type 4", "Type 5"]
    
    var body: some View {
        NavigationStack {
            VStack {
                GroupBox {
                    TextField("Beehive Name", text: $beehiveName)
                    TextField("Population", value: $population, formatter: numberFormatter)
                    TextField("Number of queens", value: $numberOfQueens, formatter: numberFormatter)
                    HStack {
                        Text("Choose queen type")
                        Spacer()
                        Picker("", selection: $queenType) {
                            ForEach(types, id: \.self) { Text($0) }
                        }
                    }
                    .padding(.horizontal, 4)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .foregroundColor(Color.white)
                    )
                    

                }
                .textFieldStyle(.roundedBorder)
                
                    
                Button("Save") {
                    let newBeehive = Beehive(name: beehiveName,
                                             population: population,
                                             numberOfQueens: numberOfQueens,
                                             queenType: queenType,
                                             age: 1,
                                             notes: [])
                    appData.addBeehive(in: location, for: newBeehive)
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
