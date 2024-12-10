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
    @EnvironmentObject var entryController: EntryController
    @EnvironmentObject var onboardingController: OnboardingController

    @Query(sort: \Entry.date, order: .reverse) var entries: [Entry]

    @State private var showTooltip = false

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
            VStack(spacing: 0) {
                AddEntryTooltip(isVisible: $showTooltip)
                AddEntryButton(showNewEntry: $navigationController.showNewEntry)
            }
        }
        .sheet(isPresented: $navigationController.showNewEntry) {
            NavigationStack {
                EditEntryView(
                    showNewEntry: $navigationController.showNewEntry,
                    activeEntry: $entryController.activeEntry
                )
                    .toolbar {
                        ToolbarItem(placement: .automatic) {
                            ToolbarDeleteButton(entry: entryController.activeEntry)
                        }
                    }
            }
        }
        .onAppear {
            showTooltip = !onboardingController.isOnboarded && entries.isEmpty
        }
    }
}

#Preview {
    let preview = Previewer()

    preview.addExamples(Entry.previewEntries)

    return NavigationStack(path: .constant(preview.navigationController.navigationPath)) {
        EntryListView()
            .withNavigationRouting(
                placement: .automatic,
                showNewEntry: preview.$navigationController.showNewEntry,
                activeEntry: preview.$entryController.activeEntry
            )
            .modelContainer(preview.modelContainer)
            .environmentObject(preview.navigationController)
            .environmentObject(preview.entryController)
            .environmentObject(preview.ideasController)
            .environmentObject(OnboardingController())
    }
}
