//
//  Constants.swift
//  DiaryAha
//
//  Created by Keeley Carrigan on 11/17/24.
//

import Foundation

enum Constants {
    enum UI {
        static let cornerRadius: CGFloat = 5
        static let defaultPadding: CGFloat = 15
        static let imageSize: CGFloat = 75
    }

    enum UserDefaultsKeys {
        static let isOnboardingComplete = "isOnboardingComplete"
    }

    enum API {
        static let baseURL = "https://lhz9bsgdi8.execute-api.us-east-2.amazonaws.com"
        static let topicsEndpoint = "/diaryAha/GetDiaryEntryTopics/"
    }
}
