//
//  ContentView.swift
//  DiaryAha
//
//  Created by Keeley Carrigan on 10/5/24.
//

import SwiftUI

struct EntryListView: View {
    @EnvironmentObject var entriesController: EntriesController
    let entryColumns = Array(repeating: GridItem(.flexible(), spacing: 10.0), count: 1)

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.secondaryColor]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.secondaryColor]
    }

    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                LazyVGrid(columns: entryColumns, spacing: 20) {

                    ForEach(entriesController.entries) { entry in
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
    EntryListView()
        .environmentObject(EntriesController(Entry.previewEntries))
}
