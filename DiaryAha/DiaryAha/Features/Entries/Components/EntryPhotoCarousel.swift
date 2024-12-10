//
//  VibeSelector.swift
//  DiaryAha
//
//  Created by Keeley Carrigan on 11/4/24.
//

import SwiftUI

struct EntryPhotoCarousel: View {
    var entryPhotos: [Data]

    var viewerHeight: CGFloat = 100
    var hasPhotos: Bool { !entryPhotos.isEmpty }
    var frameHeight: CGFloat { hasPhotos ? viewerHeight : 0 }

    var body: some View {
        TabView {
            ForEach(0..<entryPhotos.count, id: \.self) { photo in
                let image = UIImage(data: entryPhotos[photo])

                Image(uiImage: image!)
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: .fill)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: frameHeight)
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .automatic))
    }
}

#Preview {
    struct Preview: View {
        var entryPhotos: [Data] = Entry.previewEntries[0].photos

        var body: some View {
            VStack {
                EntryPhotoCarousel(entryPhotos: entryPhotos, viewerHeight: 200)
                    .cornerRadius(5, corners: [.topLeft, .topRight])
                    .padding(.bottom, -5)
            }
            .padding(.horizontal, 10)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.backgroundColor)
        }
    }

    return Preview()
}
