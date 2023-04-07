//
//  DataModel.swift
//  Beehives
//
//  Created by Yuri Gerasimchuk on 06.04.2023.
//

import Foundation

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
    let population: Int
    let numberOfQueens: Int
    let queenType: String
    let age: Int
    var notes: [Note]
    
    static func == (lhs: Beehive, rhs: Beehive) -> Bool {
        lhs.id == rhs.id
    }
}

struct Note: Codable, Identifiable, Equatable {
    var id = UUID()
    let date: Date
    var content: String
    
    static func == (lhs: Note, rhs: Note) -> Bool {
        lhs.id == rhs.id
    }
}
