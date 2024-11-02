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
        VStack(alignment: .leading) {
            HStack(alignment: .bottom) {
                Text(entry.title)
                    .font(.title)
                    .fontWeight(.heavy)
                Spacer()
                VibeImageView(vibe: entry.vibe)
            }
            .foregroundStyle(Color.mainColor)
            .padding(.top, 24)
            .padding(.bottom, 16)

            Text(entry.body)
                .font(.system(size: 18, weight: .regular))
                .foregroundStyle(Color.secondaryColor)

            Spacer()
        }
        .padding(.horizontal, 16)
        .background(Color.backgroundColor)
    }
}

#Preview {
    EntryDetailView(entry: Entry.previewEntries[0])
}
