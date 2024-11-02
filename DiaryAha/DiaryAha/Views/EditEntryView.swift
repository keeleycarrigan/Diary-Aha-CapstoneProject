//
//  EditEntryView.swift
//  DiaryAha
//
//  Created by Keeley Carrigan on 10/20/24.
//

import PhotosUI
import SwiftUI

struct EditEntryView: View {
    @EnvironmentObject var entriesController: EntriesController
    @Binding var showNewEntry: Bool
    @State private var pickedPhotos = [PhotosPickerItem]()
    @State private var entryPhotos = [Entry.PhotoMedia]()
    @State private var entryTitle = ""
    @State private var entryBody = ""
    @State private var entryVibe: VibeImages = .happy

    func onTapVibe(vibe: VibeImages) {
        entryVibe = vibe
    }

    var body: some View {
        ScrollView {
            VibeSelector(selectedVibe: $entryVibe,  onTap: onTapVibe)
                .frame(maxWidth: .infinity, maxHeight: 100)
                .padding(.bottom, 15)

            TextInput("Title", text: $entryTitle)
            TextInput("Entry", text: $entryBody, axis: .vertical)
                .lineLimit(10...15)

            EntryPhotoCarousel(entryPhotos: $entryPhotos)

            PhotosPicker("Select images", selection: $pickedPhotos, matching: .images)

            Spacer()

            WideButton("Save") {
                let newEntry = Entry(
                    title: entryTitle,
                    body: entryBody,
                    date: Date(),
                    vibe: entryVibe,
                    photos: entryPhotos
                )

                entriesController.addEntry(newEntry)
                showNewEntry = false
            }
        }
        .padding(10)
        .background(Color.backgroundColor)
        .onChange(of: pickedPhotos) {
            Task {
                entryPhotos.removeAll()

                for item in pickedPhotos {
                    if let image = try? await item.loadTransferable(type: Data.self) {
                        let mediaFile = UIImage(data: image) ?? UIImage()
                        let displayName = item.itemIdentifier ?? ""
                        let photo = Entry.PhotoMedia(displayName: displayName, mediaFile: mediaFile)

                        entryPhotos.append(photo)
                    }
                }
            }
        }
    }
}

#Preview {
    struct Preview: View {
        @State var showNewEntry: Bool = false

        var body: some View {
            EditEntryView(showNewEntry: $showNewEntry)
        }
    }

    return Preview()
            .environmentObject(EntriesController())
}
