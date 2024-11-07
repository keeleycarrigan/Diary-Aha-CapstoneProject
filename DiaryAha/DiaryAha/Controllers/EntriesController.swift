//
//  EntryListViewController.swift
//  DiaryAha
//
//  Created by Keeley Carrigan on 11/2/24.
//

import Foundation
import Observation

@Observable
final class EntriesController: ObservableObject {
    var entries: [Entry]

    init(_ entries: [Entry] = []) {
        self.entries = entries
    }

    func addEntry(_ entry: Entry) {
        entries.append(entry)
    }

    func removeEntry(_ entry: Entry) {
        entries.removeAll(where: { $0 == entry })
    }
}
