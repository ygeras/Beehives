//
//  ApplicationData.swift
//  Beehive
//
//  Created by Yuri Gerasimchuk on 06.04.2023.
//

import SwiftUI

class ApplicationData: ObservableObject {
    @Published private(set) var locations: [Location]
    
    let savePath = FileManager.documentsDirectory.appending(path: "SavedLocations")
    
    static let mockData = [
        Location(name: "Location One",
                 beehives: [Beehive(name: "Beehive One",
                                    population: 10000,
                                    numberOfQueens: 2,
                                    queenType: "Queen 1",
                                    age: 10,
                                    notes: [Note(date: Date(), content: "Content One")]
                                   )])]
    
    init() {
        // For preview purposes
        /*
        let notes = [
            Note(content: "Note One"),
            Note(content: "Note Two"),
            Note(content: "Note Three"),
            Note(content: "Note Four"),
            Note(content: "Note Five")
        ]
        let beehives = [
            Beehive(name: "Beehive 1", age: 10, notes: notes),
            Beehive(name: "Beehive 2", age: 11, notes: notes),
            Beehive(name: "Beehive 3", age: 12, notes: notes),
            Beehive(name: "Beehive 4", age: 13, notes: notes),
            Beehive(name: "Beehive 5", age: 14, notes: notes)
        
        ]
        locations = [
            Location(name: "Location 1", beehives: beehives),
            Location(name: "Location 2", beehives: beehives),
            Location(name: "Location 3", beehives: beehives),
            Location(name: "Location 4", beehives: beehives),
            Location(name: "Location 5", beehives: beehives)
        ]
         */
        
        do {
            let data = try Data(contentsOf: savePath)
            locations = try JSONDecoder().decode([Location].self, from: data)
        } catch {
            locations = []
        }
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(locations)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    func addLocation(item: Location) {
        locations.append(item)
        save()
    }
    
    func addBeehive(in location: Location, for beehive: Beehive) {
        if let index = locations.firstIndex(of: location) {
            locations[index].beehives.append(beehive)
            save()
        }
    }
    
    func addNote(in location: Location, for beehive: Beehive, note: Note) {
        if let locationIndex = locations.firstIndex(of: location) {
            if let beehiveIndex = locations[locationIndex].beehives.firstIndex(of: beehive) {
                locations[locationIndex].beehives[beehiveIndex].notes.append(note)
                save()
            }
        }
    }
    
    func removeLocation(_ item: Location) {
        var indexes = IndexSet()
        if let index = locations.firstIndex(of: item) {
            indexes.insert(index)
        }
        locations.remove(atOffsets: indexes)
        save()
    }
    
    func removeBeehive(in location: Location, for beehive: Beehive) {
        var indexes = IndexSet()
        if let locationIndex = locations.firstIndex(of: location) {
            if let beehiveIndex = locations[locationIndex].beehives.firstIndex(of: beehive) {
                indexes.insert(beehiveIndex)
            }
            locations[locationIndex].beehives.remove(atOffsets: indexes)
            save()
        }
    }
    
    func removeNote(in location: Location, for beehive: Beehive, note: Note) {
        var indexes = IndexSet()
        if let locationIndex = locations.firstIndex(of: location) {
            if let beehiveIndex = locations[locationIndex].beehives.firstIndex(of: beehive) {
                if let noteIndex = locations[locationIndex].beehives[beehiveIndex].notes.firstIndex(of: note) {
                    indexes.insert(noteIndex)
                }
                locations[locationIndex].beehives[beehiveIndex].notes.remove(atOffsets: indexes)
                save()
            }
        }
    }
    
    
}
