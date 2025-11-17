//
//  AddNoteViewModel.swift
//  WeatherNotes
//
//  Created by Irina Gorbachenko on 17.11.2025.
//
import SwiftUI

class AddNotesViewModel: ObservableObject {
    let store = NotesStorage()
    
    @Published var noteTitle: String = ""
    
    func save() {
        let newNote = Note(title: noteTitle, createdAt: Date(), temperature:34, icon: nil)
        store.add(newNote)
    }
}
