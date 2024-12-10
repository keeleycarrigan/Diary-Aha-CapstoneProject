//
//  EntryListItem.swift
//  DiaryAha
//
//  Created by Keeley Carrigan on 10/14/24.
//

import SwiftUI

struct EntryListItemView: View {
    var entry: Entry
    var title = "Title"
    var date = ""
    var vibe: VibeImages
    var photo: Image?
    var hasPhotos: Bool { !entry.photos.isEmpty }

    init(entry: Entry) {
        self.entry = entry
        self.title = entry.title
        self.date = entry.date.entryFormat()
        self.vibe = entry.vibe

        if hasPhotos {
            self.photo = Image(uiImage: UIImage(data: entry.photos[0])!)
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            TabView {
                self.photo?
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            .frame(maxHeight: hasPhotos ? 100 : 0)
            .aspectRatio(contentMode: .fill)
            .cornerRadius(5, corners: [.topLeft, .topRight])
            .padding(.bottom, -5)
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .automatic))

            HStack(alignment: .center, spacing: 0) {
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .truncationMode(.tail)

                    Spacer()

                    Text(date)
                        .font(.headline)
                }
                .foregroundStyle(.white)
                .padding(.horizontal, 15)
                .padding(.vertical, 10)

                Spacer()

                ZStack {
                    VibeImageView(vibe: vibe)
                        .padding(.top, -20)
                        .padding(.trailing, 10)
                }
            }
            .background {
                RoundedRectangle(cornerSize: .init(width: 5, height: 5))
                    .fill(Color.mainColor)
            }
        }
        .padding(.top, hasPhotos ? 0 : 10)
    }
}

#Preview {
    ScrollView(.vertical) {
        VStack(alignment: .center) {
            EntryListItemView(entry: Entry.previewEntries[0])
                .padding(.top, 20)
            EntryListItemView(entry: Entry.previewEntries[3])
                .padding(.top, 20)
        }
    }
    .padding(.horizontal, 10)
}
