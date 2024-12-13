//
//  EntryController.swift
//  DiaryAha
//
//  Created by Keeley Carrigan on 12/10/24.
//

import Foundation
import SwiftUI
import Observation
import SwiftData

@Observable
final class EntryController: ObservableObject {
    var activeEntry: Entry?

    private func validateEntry(title: String, body: String) throws {
        if title.isEmpty {
            throw ValidationError.emptyField("Title")
        }
        if body.isEmpty {
            throw ValidationError.emptyField("Entry body")
        }
        if title.count > 100 {
            throw ValidationError.exceedsMaxLength("Title", 100)
        }
    }

    func saveEntry(modelContext: ModelContext, entry: Entry) throws {
        try validateEntry(title: entry.title, body: entry.body)

        if let newEntry = activeEntry {
            newEntry.title = entry.title
            newEntry.body = entry.body
            newEntry.vibe = entry.vibe
            newEntry.date = entry.date
            newEntry.photos = entry.photos
        } else {
            modelContext.insert(entry)
        }
    }
}
