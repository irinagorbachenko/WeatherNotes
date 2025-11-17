//
//  NoteListViewModel.swift
//  WeatherNotes
//
//  Created by Irina Gorbachenko on 17.11.2025.
//
import SwiftUI


class NoteListViewModel: ObservableObject {
    @Published var notes: [Note] = [
        Note(id: UUID(),title: "Walking", createdAt: Date(), temperature: 18, icon: nil),
        Note(id: UUID(),title: "Running", createdAt: Date(), temperature: 24, icon: nil),
        Note(id: UUID(),title: "Park", createdAt: Date(), temperature: 16, icon: nil)
    ]
}
