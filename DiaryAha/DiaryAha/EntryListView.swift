//
//  ContentView.swift
//  DiaryAha
//
//  Created by Keeley Carrigan on 10/5/24.
//

import SwiftUI

struct EntryListView: View {
    var entries: [Entry]
    let columnCount: Int = 1
    let gridSpacing: CGFloat = 10

    init(entries: [Entry]) {
        self.entries = entries

        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.secondaryColor]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.secondaryColor]
    }

    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: gridSpacing), count: columnCount), spacing: 20) {

                    ForEach(entries) { entry in
                        NavigationLink {
                            EntryDetailView(entry: entry)
                        } label: {
                            EntryListItemView(entry: entry)
                                .padding(.top, 20)
                                .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                        }
                    }
                }
                .padding(.horizontal, 10)
            }
            .navigationTitle("Diary Aha!")
            .background(Color.backgroundColor.gradient)
            .safeAreaInset(edge: VerticalEdge.bottom) {
                AddEntryButtonView()
            }
        }
        .tint(Color.secondaryColor)

    }
}

#Preview {
    EntryListView(entries: Entry.previewEntries)
}

