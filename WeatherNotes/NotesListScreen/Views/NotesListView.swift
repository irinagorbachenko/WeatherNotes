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
        NavigationStack {
            List {
                ForEach(viewModel.notes) { note in
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
                        }
                    }
                }
            }
            .navigationTitle("Notes")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        print("Pressed")
                    } label: {
                        Text("Add")
                    }
                }
            }
        }
    }
}

#Preview {
    NotesListView()
}
