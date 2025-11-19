//
//  AddNoteView.swift
//  WeatherNotes
//
//  Created by Irina Gorbachenko on 17.11.2025.
//
import SwiftUI

struct AddNoteView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: AddNotesViewModel

    var body: some View {
        ZStack {
            VStack {
                NoteTextField(text: $viewModel.noteTitle)
                Spacer()
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.top, AddNoteConstants.topPadding)
        }
        .navigationTitle("Add Note")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                SaveButton(isLoading: viewModel.isLoading) { saveNote() }
            }
        }
        .alert("Error", isPresented: Binding(
            get: { viewModel.errorMessage != nil },
            set: { _ in viewModel.errorMessage = nil }
        )) {
            Button("Ok", role: .cancel) {}
            Button("Retry", role: .cancel) { saveNote() }
        } message: {
            Text(viewModel.errorMessage ?? "")
        }
    }

    private func saveNote() {
        Task {
            try await viewModel.save()
            dismiss()
        }
    }
}

private struct NoteTextField: View {
    @Binding var text: String

    var body: some View {
        TextField("Enter activity", text: $text)
            .padding(.horizontal, AddNoteConstants.textFieldHorizontalPadding)
            .padding(.vertical, AddNoteConstants.textFieldVerticalPadding)
            .frame(maxWidth: AddNoteConstants.textFieldWidth)
            .background(
                RoundedRectangle(cornerRadius: AddNoteConstants.textFieldCornerRadius)
                    .fill(Color(.secondarySystemBackground))
            )
            .overlay(
                RoundedRectangle(cornerRadius: AddNoteConstants.textFieldCornerRadius)
                    .stroke(Color.blue.opacity(0.5), lineWidth: 1)
            )
            .font(.system(size: 16, weight: .medium))
            .tint(.blue)
            .padding(.horizontal)
    }
}

private struct SaveButton: View {
    var isLoading: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            if isLoading {
                ProgressView()
            } else {
                Text("Save")
            }
        }
    }
}

private enum AddNoteConstants {
    static let textFieldWidth: CGFloat = 350
    static let textFieldCornerRadius: CGFloat = 14
    static let textFieldHorizontalPadding: CGFloat = 16
    static let textFieldVerticalPadding: CGFloat = 12
    static let topPadding: CGFloat = 24
}

#Preview {
    NavigationStack {
        AddNoteView(
            viewModel: AddNotesViewModel(store: NotesStorage())
        )
    }
}
