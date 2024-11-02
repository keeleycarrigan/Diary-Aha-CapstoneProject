//
//  DiaryAhaApp.swift
//  DiaryAha
//
//  Created by Keeley Carrigan on 10/5/24.
//

import SwiftUI
import SwiftData

@main
struct DiaryAhaApp: App {
    @StateObject private var entriesController: EntriesController

    init() {
        self._entriesController = .init(wrappedValue: EntriesController(Entry.previewEntries))
    }

    var body: some Scene {
        WindowGroup {
            EntryListView()
                .environmentObject(entriesController)
        }
    }
}
