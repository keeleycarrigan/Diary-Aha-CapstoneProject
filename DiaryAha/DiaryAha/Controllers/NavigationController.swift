//
//  AppController.swift
//  DiaryAha
//
//  Created by Keeley Carrigan on 12/3/24.
//

import Foundation
import SwiftUI
import Observation

@Observable
final class NavigationController: ObservableObject {
    var navigationPath: [NavigationDestination] = []

    func navigateToRoot() {
        navigationPath.removeAll()
    }
}
