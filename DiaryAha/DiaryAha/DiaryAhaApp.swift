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

    var body: some Scene {
        WindowGroup {
            EntryListView()
        }
        .modelContainer(for: Entry.self)
    }
}
