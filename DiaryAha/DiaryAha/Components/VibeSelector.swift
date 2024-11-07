//
//  VibeSelector.swift
//  DiaryAha
//
//  Created by Keeley Carrigan on 11/4/24.
//

import SwiftUI

struct VibeSelector: View {
    let vibeRows = Array(repeating: GridItem(.flexible(minimum: 75, maximum: 85), spacing: 10), count: 1)
    let onTap: (VibeImages) -> Void

    @Binding var selectedVibe: VibeImages

    init(selectedVibe: Binding<VibeImages>, onTap: @escaping (VibeImages) -> Void) {
        _selectedVibe = selectedVibe
        self.onTap = onTap
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
