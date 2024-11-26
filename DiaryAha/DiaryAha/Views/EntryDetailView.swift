//
//  EntryDetailView.swift
//  DiaryAha
//
//  Created by Keeley Carrigan on 10/17/24.
//

import SwiftUI

struct EntryDetailView: View {
    var entry: Entry

    var body: some View {
        VStack(spacing: 0) {
            EntryPhotoCarousel(entryPhotos: entry.photos, viewerHeight: 200)
                .padding(.bottom, entry.hasPhotos ? -20 : 0)

            VStack(alignment: .leading, spacing: 0) {

                HStack(alignment: .bottom) {
                    Text(entry.title)
                        .font(.title)
                        .fontWeight(.heavy)
                    Spacer()
                    VibeImageView(vibe: entry.vibe)
                }
                .foregroundStyle(Color.mainColor)
                .padding(.bottom, 15)

                Text(entry.body)
                    .font(.system(size: 20, weight: .regular))
                    .foregroundStyle(Color.secondaryColor)

                Spacer()
            }
            .padding(.horizontal, 15)
        }
        .background(Color.backgroundColor)
    }
}

#Preview {
    EntryDetailView(entry: Entry.previewEntries[0])
}
