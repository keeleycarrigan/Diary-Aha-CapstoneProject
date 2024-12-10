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
    @EnvironmentObject var navigationController: NavigationController
    @EnvironmentObject var appController: AppController
    @Query(sort: \Entry.date, order: .reverse) var entries: [Entry]

    let entryColumns = Array(repeating: GridItem(.flexible(), spacing: 10.0), count: 1)

    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: entryColumns, spacing: 20) {
                ForEach(entries) { entry in
                    NavigationLink(value: NavigationDestination.entryDetail(entry)) {
                        EntryListItemView(entry: entry)
                    }
                }
            }
            .padding(.horizontal, 10)
        }
        .navigationTitle("Diary Aha!")
        .background(Color.backgroundColor.gradient)
        .safeAreaInset(edge: VerticalEdge.bottom) {
            AddEntryButtonView(showNewEntry: $navigationController.showNewEntry)
        }
        .sheet(isPresented: $navigationController.showNewEntry) {
            NavigationStack {
                EditEntryView(
                    showNewEntry: $navigationController.showNewEntry,
                    activeEntry: $appController.activeEntry
                )
                    .toolbar {
                        ToolbarItem(placement: .automatic) {
                            ToolbarDeleteButton(entry: appController.activeEntry)
                        }
                    }
            }
        }
    }
}

#Preview {
    let preview = Previewer()

    preview.addExamples(Entry.previewEntries)

    return EntryListView()
        .modelContainer(preview.modelContainer)
        .environmentObject(preview.navigationController)
        .environmentObject(preview.appController)
}
