//
//  ContentView.swift
//  DiaryAha
//
//  Created by Keeley Carrigan on 10/5/24.
//

import SwiftUI
import SwiftData

struct EntryListView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Entry.date, order: .reverse) var entries: [Entry]

    let entryColumns = Array(repeating: GridItem(.flexible(), spacing: 10.0), count: 1)

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.secondaryColor]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.secondaryColor]
    }

    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                LazyVGrid(columns: entryColumns, spacing: 20) {

                    ForEach(entries) { entry in
                        NavigationLink {
                            EntryDetailView(entry: entry)
                        } label: {
                            EntryListItemView(entry: entry)
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
    let preview = Previewer()

    preview.addExamples(Entry.previewEntries)

    return EntryListView()
        .modelContainer(preview.modelContainer)
}
