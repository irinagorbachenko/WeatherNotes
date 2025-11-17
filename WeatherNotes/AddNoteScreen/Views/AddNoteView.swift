//
//  AddNoteView.swift
//  WeatherNotes
//
//  Created by Irina Gorbachenko on 17.11.2025.
//
import SwiftUI

struct AddNoteView: View {
    @StateObject var viewModel = AddNotesViewModel()
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack {
                TextField("Enter activity", text: $viewModel.noteTitle)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(
                        RoundedRectangle(cornerRadius: 14)
                            .fill(Color(.secondarySystemBackground))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color.blue.opacity(0.5), lineWidth: 1)
                    )
                    .font(.system(size: 16, weight: .medium))
                    .tint(.blue)
                    .padding(.horizontal)
                
                Spacer()
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, 24)
        }
        .navigationTitle("Add Note")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    
                } label: {
                    
                    Text("Save")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddNoteView()
    }
}
