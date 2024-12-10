//
//  NavigationRouter.swift
//  DiaryAha
//
//  Created by Keeley Carrigan on 12/10/24.
//

import SwiftUI

struct NavigationRouter: ViewModifier {
    @Binding var showNewEntry: Bool
    @Binding var activeEntry: Entry?

    func body(content: Content) -> some View {
        content.navigationDestination(for: NavigationDestination.self) { destination in
            switch destination {
            case .entryList:
                EntryListView()
            case .entryDetail(let entry):
                EntryDetailView(entry: entry)
                    .toolbar {
                        ToolbarItem(placement: .automatic) {
                            ToolbarEditButton(
                                entry: entry,
                                showNewEntry: $showNewEntry,
                                activeEntry: $activeEntry
                            )
                        }
                    }
            }
        }
    }
}

// Add a View extension for easier use
extension View {
    func withNavigationRouting(
        placement: ToolbarItemPlacement,
        showNewEntry: Binding<Bool>,
        activeEntry: Binding<Entry?>
    ) -> some View {
        modifier(NavigationRouter(
            showNewEntry: showNewEntry,
            activeEntry: activeEntry
        ))
    }
}
