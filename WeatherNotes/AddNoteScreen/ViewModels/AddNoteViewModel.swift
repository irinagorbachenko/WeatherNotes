//
//  AddNoteViewModel.swift
//  WeatherNotes
//
//  Created by Irina Gorbachenko on 17.11.2025.
//
import SwiftUI

class AddNotesViewModel: ObservableObject {
    let weatherService = WeatherService()
    var store = NotesStorage()
    
    init(store: NotesStorage) {
            self.store = store
        }
    
    @Published var noteTitle: String = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    @MainActor
    func save() async -> Bool{
        do {
            isLoading = true
            let currentWeather = try await weatherService.currentWeather()
            let newNote = Note(title: noteTitle, createdAt: Date(), temperature: currentWeather.main.feelsLike, icon: currentWeather.weather.first?.icon)
            store.add(newNote)
            isLoading = false
             return true
        } catch {
                self.errorMessage = error.localizedDescription
            return false
        }
    }
}
