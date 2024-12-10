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
    @StateObject var appController = AppController()

    var body: some Scene {
        WindowGroup {
            EntryListView()
        }
        .modelContainer(for: Entry.self)
        .environmentObject(navigationController)
        .environmentObject(appController)
    }
}
