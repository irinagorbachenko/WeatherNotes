//
//  NoteListViewModel.swift
//  WeatherNotes
//
//  Created by Irina Gorbachenko on 17.11.2025.
//
import SwiftUI


class NoteListViewModel: ObservableObject {
    @Published var notes: [Note] = []
}
