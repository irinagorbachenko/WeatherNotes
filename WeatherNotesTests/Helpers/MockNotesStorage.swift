//
//  MockNotesStorage.swift
//  WeatherNotes
//
//  Created by Irina Gorbachenko on 19.11.2025.

@testable import WeatherNotes

class MockNotesStorage: NotesStorageProvider {
    var addedNotes: [Note] = []

    func add(_ note: Note) {
        addedNotes.append(note)
    }

    var allNotes: [Note] {
        addedNotes
    }
}
