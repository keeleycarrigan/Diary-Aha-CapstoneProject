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

    @Binding var showNewEntry: Bool
    @State private var pickedPhotos = [PhotosPickerItem]()
    @State private var entryPhotos = [Data]()
    @State private var entryTitle = ""
    @State private var entryBody = ""
    @State private var entryVibe: VibeImages = .happy
    @State private var entryIdeas: [String] = []

    func onTapVibe(vibe: VibeImages) {
        entryVibe = vibe
    }

    func getIdeas() {
        guard let url = URL(string: Constants.getTopicsURL) else {
            return print("Invalid URL")
        }

        var request = URLRequest(url: url)

        request.httpMethod = "GET"

        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            guard let data else { return }

            do {
                let response = try JSONDecoder().decode(TopicIdeas.self, from: data)
                entryIdeas = response.body
            } catch {
                print(error)
            }
        }

        task.resume()
    }

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VibeSelector(selectedVibe: $entryVibe,  onTap: onTapVibe)
                    .frame(maxWidth: .infinity)
                    .frame(height: 100)

                GetIdeasView()

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
                    let newEntry = Entry(
                        title: entryTitle,
                        body: entryBody,
                        date: Date(),
                        vibe: entryVibe,
                        photos: entryPhotos
                    )

                    modelContext.insert(newEntry)
                    showNewEntry = false
                }
            }
            .padding(.horizontal, 10)
            .padding(.bottom, 20)
            .padding(.top, 10)
            .background(Color.backgroundColor)
        }
    }
}

#Preview {
    @Previewable @State var showNewEntry: Bool = false
    let preview = Previewer()

    EditEntryView(showNewEntry: $showNewEntry).modelContainer(preview.modelContainer)
}
