//
//  MockNotesStorage.swift
//  WeatherNotes
//
//  Created by Irina Gorbachenko on 19.11.2025.

@testable import WeatherNotes

class MockNotesStorage: NotesStorage {
    var addedNotes: [Note] = []
    
    override func add(_ note: Note) {
        addedNotes.append(note)
    }
    
    override var allNotes: [Note] {
        addedNotes
    }
}
