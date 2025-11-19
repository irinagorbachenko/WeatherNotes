//
//  AddNoteViewModel.swift
//  WeatherNotes
//
//  Created by Irina Gorbachenko on 17.11.2025.
//
import SwiftUI

class AddNotesViewModel: ObservableObject {
    @Published var noteTitle: String = ""
    @Published var city: String = "Kyiv"
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let weatherService: WeatherService
    let store: NotesStorage
    
    init(weatherService: WeatherService = WeatherService(),
         store: NotesStorage = NotesStorage()) {
        self.weatherService = weatherService
        self.store = store
    }
    
    @MainActor
    func save() async throws {
        do {
            isLoading = true
            let currentWeather = try await weatherService.currentWeather(for: city)
            let newNote = Note(title: noteTitle, createdAt: Date(), temperature: currentWeather.main.feelsLike, icon: currentWeather.weather.first?.icon)
            store.add(newNote)
            isLoading = false
        } catch {
            self.errorMessage = error.localizedDescription
            throw error
        }
    }
}
