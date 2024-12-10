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
    @StateObject var navigationController = NavigationController()
    @StateObject var ideasController = IdeasController()
    @StateObject var entryController = EntryController()
    @StateObject var onboardingController = OnboardingController()

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.secondaryColor]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.secondaryColor]
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $navigationController.navigationPath) {
                EntryListView()
                    .withNavigationRouting(
                        placement: .automatic,
                        showNewEntry: $navigationController.showNewEntry,
                        activeEntry: $entryController.activeEntry
                    )
            }
            .tint(Color.secondaryColor)
        }
        .modelContainer(for: Entry.self)
        .environmentObject(navigationController)
        .environmentObject(entryController)
        .environmentObject(ideasController)
        .environmentObject(onboardingController)
    }
}
