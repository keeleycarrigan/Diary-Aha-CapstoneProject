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
    let testEntries: [Entry] = [
        Entry(title: "First Entry", body: "Body", date: Date(), vibe: ""),
        Entry(title: "First Entry", body: "Body", date: Date(), vibe: ""),
        Entry(title: "First Entry", body: "Body", date: Date(), vibe: ""),
        Entry(title: "First Entry", body: "Body", date: Date(), vibe: ""),
        Entry(title: "First Entry", body: "Body", date: Date(), vibe: ""),
        Entry(title: "First Entry", body: "Body", date: Date(), vibe: ""),
        Entry(title: "First Entry", body: "Body", date: Date(), vibe: ""),
        Entry(title: "First Entry", body: "Body", date: Date(), vibe: "")
    ]

    var body: some Scene {
        WindowGroup {
            EntryListView(entries: testEntries)
        }
    }
}