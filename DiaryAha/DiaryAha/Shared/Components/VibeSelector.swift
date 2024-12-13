//
//  VibeSelector.swift
//  DiaryAha
//
//  Created by Keeley Carrigan on 11/4/24.
//

import SwiftUI

struct VibeSelector: View {
    let vibeRows: [GridItem]
    let onTap: (VibeImages) -> Void

    @Binding var selectedVibe: VibeImages

    init(selectedVibe: Binding<VibeImages>, onTap: @escaping (VibeImages) -> Void) {
        let selectedImageSize = Constants.UI.imageSize + 10.0
        let gridItemSize: GridItem.Size = .flexible(minimum: Constants.UI.imageSize, maximum: selectedImageSize)
        let gridItem = GridItem(gridItemSize, spacing: 10)

        _selectedVibe = selectedVibe
        self.onTap = onTap
        self.vibeRows = Array(repeating: gridItem, count: 1)
    }

    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: vibeRows) {
                ForEach(VibeImages.allCases) { vibe in
                    Image(vibe.id)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(5)
                        .scaleEffect(vibe == selectedVibe ? 1.1 : 1)
                        .animation(.easeOut(duration: 0.2), value: selectedVibe)
                        .onTapGesture {
                            onTap(vibe)
                        }

                }
            }
            .padding(.horizontal, 5)
        }
    }
}

#Preview {
    struct Preview: View {
        @State var selectedVibe: VibeImages = .anxious

        var body: some View {
            VibeSelector(selectedVibe: $selectedVibe) { vibe in
                selectedVibe = vibe
                print("\(vibe.id)")
            }
        }
    }

    return Preview()
}
