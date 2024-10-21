//
//  EditEntryView.swift
//  DiaryAha
//
//  Created by Keeley Carrigan on 10/20/24.
//

import PhotosUI
import SwiftUI

struct EditEntryView: View {
    @State private var selectedPhotos = [PhotosPickerItem]()
    @State private var entryPhotos = [Image]()

    var body: some View {
        ScrollView {
            PhotosPicker("Select images", selection: $selectedPhotos, matching: .images)
            LazyHGrid(rows: Array(repeating: GridItem(.flexible(), spacing: 10), count: 1), spacing: 20.0) {
                ForEach(0..<entryPhotos.count, id: \.self) { photo in
                    entryPhotos[photo]
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                }
            }
        }
        .onChange(of: selectedPhotos) {
            Task {
                entryPhotos.removeAll()

                for item in selectedPhotos {
                    if let image = try? await item.loadTransferable(type: Image.self) {
                        entryPhotos.append(image)
                    }
                }
            }
        }
    }
}

#Preview {
    EditEntryView()
}
