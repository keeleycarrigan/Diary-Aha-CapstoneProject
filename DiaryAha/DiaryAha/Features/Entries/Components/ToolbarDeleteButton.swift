//
//  ToolbarDeleteButton.swift
//  DiaryAha
//
//  Created by Keeley Carrigan on 12/10/24.
//

import SwiftUI

struct ToolbarDeleteButton: View {
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var navigationController: NavigationController

    var entry: Entry?
    var hasActiveEntry: Bool { entry != nil }

    var body: some View {
        Button {
            if let entry {
                self.modelContext.delete(entry)
                self.navigationController.navigateToRoot()
                self.navigationController.showNewEntry.toggle()
            }
        } label: {
            Text("Delete")
        }
        .opacity(hasActiveEntry ? 1 : 0)
        .allowsHitTesting(hasActiveEntry)
    }
}

#Preview {
    let preview = Previewer()

    ToolbarDeleteButton()
        .modelContainer(preview.modelContainer)
        .environmentObject(preview.navigationController)
}
