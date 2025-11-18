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
            Image("Clouds")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            Color.black.opacity(0.2)
                .ignoresSafeArea()
            VStack(spacing: 16) {
                Text(note.title)
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                
                Text(note.formattedDate)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
                
                Text(note.formattedTemperature)
                    .font(.headline)
                    .foregroundColor(.red)
                
                if let iconURL = note.iconURL {
                    AsyncImage(url: iconURL) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 100, height: 100)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                        case .failure:
                            Image(systemName: "questionmark.square.dashed")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.gray)
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else {
                    Image(systemName: "questionmark.square.dashed")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                }
                
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
        DetailsNotesView(note: Note(title: "Sample Note", createdAt: Date(), temperature: 22.5, icon: "10d"))
    }
}
