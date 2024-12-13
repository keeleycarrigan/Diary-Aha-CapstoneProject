//
//  Previewer.swift
//  DiaryAha
//
//  Created by Keeley Carrigan on 11/23/24.
//

import Foundation
import SwiftUI
import SwiftData

struct Previewer {
    @StateObject var navigationController = NavigationController()
    @StateObject var ideasController = IdeasController()
    @StateObject var entryController = EntryController()
    @StateObject var onboardingController = OnboardingController()
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
