//
//  DataController.swift
//  DiaryAha
//
//  Created by Keeley Carrigan on 12/11/24.
//

import Foundation
import SwiftUI
import Observation

@Observable
final class OnboardingController: ObservableObject {
    var isOnboarded: Bool {
        get {
            UserDefaults.standard.bool(forKey: Constants.UserDefaultsKeys.isOnboardingComplete)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.UserDefaultsKeys.isOnboardingComplete)
        }
    }
}
