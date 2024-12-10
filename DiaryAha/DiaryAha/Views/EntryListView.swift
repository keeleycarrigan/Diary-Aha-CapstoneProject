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
    @Query(sort: \Entry.date, order: .reverse) var entries: [Entry]

    @State var showNewEntry: Bool = false
    @State var activeEntry: Entry?

    let entryColumns = Array(repeating: GridItem(.flexible(), spacing: 10.0), count: 1)
    let placement: ToolbarItemPlacement = .automatic

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.secondaryColor]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.secondaryColor]
    }

    var body: some View {
        NavigationStack(path: $navigationController.navigationPath) {
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
            .navigationDestination(for: NavigationDestination.self) { destination in
                switch destination {
                case .entryDetail(let entry):
                    EntryDetailView(entry: entry)
                        .toolbar {
                            ToolbarItem(placement: placement) {
                                ToolbarEditButton(
                                    entry: entry,
                                    showNewEntry: $showNewEntry,
                                    activeEntry: $activeEntry
                                )
                            }
                        }
                }
            }
            .background(Color.backgroundColor.gradient)
            .safeAreaInset(edge: VerticalEdge.bottom) {
                AddEntryButtonView(showNewEntry: $showNewEntry)
            }
        }
        .tint(Color.secondaryColor)
        .sheet(isPresented: $showNewEntry) {
            NavigationStack {
                EditEntryView(showNewEntry: $showNewEntry, activeEntry: $activeEntry)
                    .toolbar {
                        ToolbarItem(placement: placement) {
                            Button {
                                if let activeEntry {
                                    self.modelContext.delete(activeEntry)
                                }

                                self.navigationController.navigateToRoot()
                                showNewEntry.toggle()
                            } label: {
                                Text("Delete")
                            }
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
}
