//
//  ToolbarEditButton.swift
//  DiaryAha
//
//  Created by Keeley Carrigan on 12/9/24.
//

import SwiftUI

struct ToolbarEditButton: View {
    let entry: Entry
    @Binding var showNewEntry: Bool
    @Binding var activeEntry: Entry?

    var body: some View {
        Button {
            activeEntry = entry
            showNewEntry.toggle()
        } label: {
            Text("Edit")
        }
    }
}

#Preview {
    @Previewable @State var showNewEntry: Bool = false
    @Previewable @State var activeEntry: Entry?

    ToolbarEditButton(entry: Entry.previewEntries[0], showNewEntry: $showNewEntry, activeEntry: $activeEntry)
}
