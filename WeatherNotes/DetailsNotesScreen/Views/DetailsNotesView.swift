//
//  DetaildNotesScreenView.swift
//  WeatherNotes
//
//  Created by Irina Gorbachenko on 17.11.2025.
//
import SwiftUI

struct DetailsNotesView: View {
    let note: Note
   
    var body: some View {
        VStack {
            Text(note.title)
                .font(.title)
            Text(note.formattedDate)
                .font(.title2)
            Text(note.formattedTemperature)
                .font(.title2)
        }
    }
}
