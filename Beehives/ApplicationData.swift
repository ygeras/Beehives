//
//  ApplicationData.swift
//  Beehive
//
//  Created by Yuri Gerasimchuk on 06.04.2023.
//

import SwiftUI

struct Location: Codable, Identifiable, Equatable {
    var id = UUID()
    let name: String
    var beehives: [Beehive]
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}

struct Beehive: Codable, Identifiable, Equatable {
    var id = UUID()
    let name: String
    let age: Int
    var notes: [Note]
    
    static func == (lhs: Beehive, rhs: Beehive) -> Bool {
        lhs.id == rhs.id
    }
}

struct Note: Codable, Identifiable, Equatable {
    var id = UUID()
    var content: String
    
    static func == (lhs: Note, rhs: Note) -> Bool {
        lhs.id == rhs.id
    }
}

class ApplicationData: ObservableObject {
    @Published var locations = [Location]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(locations) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
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
        
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([Location].self, from: savedItems) {
                locations = decodedItems
                return
            }
        }
        
        locations = []
        
    }
    
    func saveLocation(item: Location) {
        locations.append(item)
    }
    
    func saveBeehive(in location: Location, for beehive: Beehive) {
        if let index = locations.firstIndex(of: location) {
            locations[index].beehives.append(beehive)
        }
    }
    
    func saveNote(in location: Location, for beehive: Beehive, note: Note) {
        if let locationIndex = locations.firstIndex(of: location) {
            if let beehiveIndex = locations[locationIndex].beehives.firstIndex(of: beehive) {
                locations[locationIndex].beehives[beehiveIndex].notes.append(note)
            }
        }
    }
    
    func removeLocation(_ item: Location) {
        var indexes = IndexSet()
        if let index = locations.firstIndex(of: item) {
            indexes.insert(index)
        }
        locations.remove(atOffsets: indexes)
    }
    
    func removeBeehive(in location: Location, for beehive: Beehive) {
        var indexes = IndexSet()
        if let locationIndex = locations.firstIndex(of: location) {
            if let beehiveIndex = locations[locationIndex].beehives.firstIndex(of: beehive) {
                indexes.insert(beehiveIndex)
            }
            locations[locationIndex].beehives.remove(atOffsets: indexes)
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
            }
        }
    }
    
    
}
