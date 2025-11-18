//
//  NotesListView.swift
//  WeatherNotes
//
//  Created by Irina Gorbachenko on 17.11.2025.
//
import SwiftUI

struct NotesListView: View {
    @StateObject var viewModel = NoteListViewModel()
    
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            ZStack {
                Image("Clouds")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                List {
                    ForEach(viewModel.notes) { note in
                        noteView(note)
                            .onTapGesture {
                                viewModel.showDetails(for: note)
                            }
                            .listRowBackground(
                                Rectangle()
                                    .fill(.ultraThinMaterial)
                            )
                    }
                    Color.clear
                        .frame(height: 300)
                        .listRowBackground(Color.clear)
                }
                .scrollContentBackground(.hidden)
                .listStyle(.plain)
                .frame(maxWidth: 350)
            }
            .navigationTitle("Notes")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") { viewModel.addNote() }
                }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .addNote:
                    AddNoteView()
                case .details(let note):
                    DetailsNotesView(note: note)
                }
            }
            .onAppear {
                viewModel.loadNotes()
            }
        }
    }
    
    @ViewBuilder
    private func noteView(_ note: Note) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(note.title)
                    .font(.title3)
                Text(note.formattedDate)
                    .font(.caption)
            }
            
            Spacer()
            
            VStack {
                Text(note.formattedTemperature)
                    .foregroundStyle(.red)
                
                if let iconURL = note.iconURL {
                    AsyncImage(url: iconURL) { phase in
                        switch phase {
                        case .empty: ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                        case .failure:
                            Image(systemName: "questionmark.square.dashed")
                        @unknown default: EmptyView()
                        }
                    }
                }
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    NavigationStack {
        NotesListView()
    }
}
