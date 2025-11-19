//
//  NotesStorage.swift
//  WeatherNotes
//
//  Created by Irina Gorbachenko on 17.11.2025.
//

import Foundation

class NotesStorage {
    enum Key {
        static let notesKey = "notesKey"
    }
    
    let userDefaults = UserDefaults.standard
    
    var allNotes: [Note] {
        guard let data = userDefaults.data(forKey: Key.notesKey),
              let notes = try? JSONDecoder().decode([Note].self, from: data)
        else {
            return[]
        }
        return notes
    }
    
    func add(_ note: Note) {
        var allNotes = allNotes
        allNotes.append(note)
        
        guard let data = try? JSONEncoder().encode(allNotes) else {
            return
        }
        userDefaults.set(data, forKey: Key.notesKey)
    }
}
