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
    @State private var pickerHeight: CGFloat = 0

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

                HStack(spacing: 0) {
                    Spacer()

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

                EntryDatePicker(entryDate: $entryDate) {
                    withAnimation(.easeOut(duration: 0.5)) {
                        pickerHeight = 0.0
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: pickerHeight)
                .padding(0)
                .clipped()
                .allowsHitTesting(pickerHeight > 0.0)

                TextInput("Title", text: $entryTitle)

                TextInput("Entry", text: $entryBody, axis: .vertical)
                    .lineLimit(10...15)

                PhotosPicker("Select images", selection: $pickedPhotos, matching: .images)

                EntryPhotoCarousel(entryPhotos: entryPhotos, viewerHeight: 200)
                    .cornerRadius(5)

                Spacer()
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
                    if let entry = activeEntry {
                        entry.title = entryTitle
                        entry.body = entryBody
                        entry.vibe = entryVibe
                        entry.date = entryDate
                        entry.photos = entryPhotos
                    } else {
                        let newEntry = Entry(
                            title: entryTitle,
                            body: entryBody,
                            date: entryDate,
                            vibe: entryVibe,
                            photos: entryPhotos
                        )

                        modelContext.insert(newEntry)
                    }
                    showNewEntry = false
                }
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 20)
            .padding(.top, 10)
            .background(Color.backgroundColor)
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
}
