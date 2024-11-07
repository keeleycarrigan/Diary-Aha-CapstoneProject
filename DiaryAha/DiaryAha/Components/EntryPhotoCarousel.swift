//
//  VibeSelector.swift
//  DiaryAha
//
//  Created by Keeley Carrigan on 11/4/24.
//

import SwiftUI

struct EntryPhotoCarousel: View {
    @Binding var entryPhotos: [Entry.PhotoMedia]

    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(0..<entryPhotos.count, id: \.self) { photo in
                    entryPhotos[photo].mediaImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: .infinity, height: 200)
                }
            }
        }
    }
}

#Preview {
    struct Preview: View {
        @State var entryPhotos: [Entry.PhotoMedia] = []

        var body: some View {
            EntryPhotoCarousel(entryPhotos: $entryPhotos)
        }
    }

    return Preview()
}
