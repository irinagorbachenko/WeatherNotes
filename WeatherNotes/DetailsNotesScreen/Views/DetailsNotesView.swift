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
        ZStack {
            VStack(spacing: 16) {
                Text(note.title)
                    .font(.title)
                    .bold()
                    .foregroundColor(.black)
                
                Text(note.formattedDate)
                    .font(.subheadline)
                
                Text(note.formattedTemperature)
                    .font(.headline)
                    .foregroundColor(.red)
                
                NoteIconView(iconURL: note.iconURL)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        DetailsNotesView(
            note: Note(title: "Sample Note",
                       createdAt: Date(),
                       temperature: 22.5,
                       icon: "10d"))
    }
}

private struct NoteIconView: View {
    let iconURL: URL?
    
    var body: some View {
        Group {
            if let url = iconURL {
                AsyncImage(url: url, content: imagePhaseView)
            } else {
                placeholder
            }
        }
        .frame(width: 100, height: 100)
    }
    
    @ViewBuilder
    private func imagePhaseView(_ phase: AsyncImagePhase) -> some View {
        switch phase {
        case .empty:
            ProgressView()
        case .success(let image):
            image
                .resizable()
                .scaledToFit()
        case .failure:
            placeholder
        @unknown default:
            EmptyView()
        }
    }
    
    private var placeholder: some View {
        Image(systemName: "questionmark.square.dashed")
            .resizable()
            .scaledToFit()
            .foregroundColor(.gray)
    }
}
