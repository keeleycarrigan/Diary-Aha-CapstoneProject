//
//  Previewer.swift
//  DiaryAha
//
//  Created by Keeley Carrigan on 11/23/24.
//

import Foundation
import SwiftData

struct Previewer {
    let modelContainer: ModelContainer

    init() {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        do {
            modelContainer = try ModelContainer(for: Entry.self, configurations: config)
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
    }

    func addExamples(_ examples: [Entry]) {

        Task { @MainActor in
            examples.forEach { example in
                modelContainer.mainContext.insert(example)
            }
        }

    }
}
