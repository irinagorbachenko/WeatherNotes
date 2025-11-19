//
//  NoteListViewModel.swift
//  WeatherNotes
//
//  Created by Irina Gorbachenko on 17.11.2025.
//
import SwiftUI

enum Route: Hashable {
    case addNote
    case details(Note)
}

class NoteListViewModel: ObservableObject {
    let store: NotesStorage
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
    
    func showDetails(for note: Note) {
        navigationPath.append(Route.details(note))
    }
}

#Preview {
    NavigationStack {
        NotesListView()
    }
}
