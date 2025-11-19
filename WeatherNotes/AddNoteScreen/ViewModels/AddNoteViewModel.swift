//
//  AddNoteViewModel.swift
//  WeatherNotes
//
//  Created by Irina Gorbachenko on 17.11.2025.
//
import SwiftUI

class AddNotesViewModel: ObservableObject {
    @Published var noteTitle: String = ""
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let weatherService: WeatherProvider
    private let store: NotesStorageProvider

    init(
        weatherService: WeatherProvider = WeatherService(),
        store: NotesStorageProvider = NotesStorage()
    ) {
        self.weatherService = weatherService
        self.store = store
    }

    @MainActor
    func save() async throws {
        isLoading = true
        defer { isLoading = false }

        do {
            let currentWeather = try await weatherService.currentWeather(for: "Kyiv")
            store.add(
                Note(
                    title: noteTitle,
                    createdAt: Date(),
                    temperature: currentWeather.main.feelsLike,
                    icon: currentWeather.weather.first?.icon
                )
            )
        } catch {
            errorMessage = error.localizedDescription
            throw error
        }
    }
}
