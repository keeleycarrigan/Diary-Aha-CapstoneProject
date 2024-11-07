//
//  EntryListItem.swift
//  DiaryAha
//
//  Created by Keeley Carrigan on 10/14/24.
//

import SwiftUI

struct EntryListItemView: View {
    let imageSize: CGFloat = 75.0
    var entry: Entry
    var title = "Title"
    var date = "Subtitle"
    var vibe: VibeImages

    init(entry: Entry) {
        self.entry = entry
        self.title = entry.title
        self.date = entry.date.formatted(date: .abbreviated, time: .omitted)
        self.vibe = entry.vibe
    }

    var body: some View {
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
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .foregroundStyle(.white)
            .padding(.horizontal, 15)
            .padding(.vertical, 10)

            ZStack(alignment: .trailing) {
                VibeImageView(vibe: vibe)
                    .padding(.top, -20)
                    .padding(.trailing, 10)
            }
        }
        .background(Color.mainColor)
    }
}

#Preview {
    EntryListItemView(entry: Entry.previewEntries[3])
}
