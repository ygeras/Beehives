//
//  FileManager-DocumentsDirectory.swift
//  Beehives
//
//  Created by Yuri Gerasimchuk on 07.04.2023.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
