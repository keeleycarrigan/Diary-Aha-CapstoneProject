//
//  EditEntryView.swift
//  DiaryAha
//
//  Created by Keeley Carrigan on 10/20/24.
//

import PhotosUI
import SwiftUI
import SwiftData

struct EditEntryView: View {
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var entryController: EntryController

    private let maxDatePickerHeight = 400.0

    @Binding var showNewEntry: Bool
    @Binding var activeEntry: Entry?
    @State private var pickedPhotos = [PhotosPickerItem]()
    @State private var entryPhotos = [Data]()
    @State private var entryDate: Date = Date()
    @State private var entryTitle = ""
    @State private var entryBody = ""
    @State private var entryVibe: VibeImages = .happy
    @State private var entryIdeas: [String] = []
    @State private var pickerHeight: CGFloat = 0.0
    @State private var showError = false
    @State private var errorMessage = ""

    func onTapVibe(vibe: VibeImages) {
        entryVibe = vibe
    }

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VibeSelector(selectedVibe: $entryVibe,  onTap: onTapVibe)
                    .frame(maxWidth: .infinity)
                    .frame(height: 100)

                GetIdeasView()
                    .padding(.vertical, 15)

                HStack(spacing: 0) {
                    Text(entryDate.entryFormat())
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.mainColor)
                        .onTapGesture {
                            withAnimation(.easeOut(duration: 0.5)) {
                                if (pickerHeight == maxDatePickerHeight) {
                                    pickerHeight = 0.0
                                } else {
                                    pickerHeight = maxDatePickerHeight
                                }
                            }
                        }
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                if pickerHeight > 0 {
                    EntryDatePicker(entryDate: $entryDate) {
                        withAnimation(.easeOut(duration: 0.5)) {
                            pickerHeight = 0.0
                        }
                    }
                    .frame(height: pickerHeight)
                }

                TextInput("Title", text: $entryTitle)
                    .padding(.bottom, 5)

                TextInput("Entry", text: $entryBody, axis: .vertical)
                    .lineLimit(10...15)

                PhotoPickerButton(pickedPhotos: $pickedPhotos)

                EntryPhotoCarousel(entryPhotos: entryPhotos, viewerHeight: 200)
                    .cornerRadius(5)

            }
            .padding(.horizontal, 10)
            .padding(.vertical, 0)
            .background(Color.backgroundColor)
            .onChange(of: pickedPhotos) {
                Task {
                    entryPhotos.removeAll()

                    for item in pickedPhotos {
                        if let image = try? await item.loadTransferable(type: Data.self) {
                            entryPhotos.append(image)
                        }
                    }
                }
            }

            HStack(spacing: 10) {
                WideButton("Cancel", color: Color.barberry) {
                    showNewEntry = false
                }

                WideButton("Save") {
                    do {
                        let newEntry = Entry(
                            title: entryTitle,
                            body: entryBody,
                            date: entryDate,
                            vibe: entryVibe,
                            photos: entryPhotos
                        )

                        try self.entryController.saveEntry(
                            modelContext: modelContext,
                            entry: newEntry
                        )
                        showNewEntry = false
                    } catch {
                        errorMessage = error.localizedDescription
                        showError = true
                    }
                }
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 20)
            .padding(.top, 10)
            .background(Color.backgroundColor)
            .alert("Error", isPresented: $showError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
        }
        .onAppear {
            if let entry = activeEntry {
                entryTitle = entry.title
                entryBody = entry.body
                entryVibe = entry.vibe
                entryPhotos = entry.photos
                entryDate = entry.date
            }
        }
        .onDisappear {
            activeEntry = nil
        }
    }
}

#Preview {
    @Previewable @State var showNewEntry: Bool = false
    @Previewable @State var entry: Entry?
    let preview = Previewer()

    EditEntryView(showNewEntry: $showNewEntry, activeEntry: $entry)
        .modelContainer(preview.modelContainer)
        .environmentObject(preview.entryController)
        .environmentObject(preview.ideasController)
}
