//
//  NoteListViewModel.swift
//  WeatherNotes
//
//  Created by Irina Gorbachenko on 17.11.2025.
//
import SwiftUI

enum Route: Hashable {
    case addNote
}

class NoteListViewModel: ObservableObject {
    private let store: NotesStorage
    @Published var notes: [Note] = []
    @Published var navigationPath = NavigationPath()
    
    init(store: NotesStorage = NotesStorage()) {
        self.store = store
        notes = store.allNotes
    }
    
    func addNote() {
        navigationPath.append(Route.addNote)
    }
    
    func loadNotes() {
        notes = store.allNotes
    }
}
