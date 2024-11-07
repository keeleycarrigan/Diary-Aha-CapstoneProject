//
//  Date.swift
//  DiaryAha
//
//  Created by Keeley Carrigan on 11/4/24.
//

import Foundation

extension Date {
    init (month: Int, day: Int, year: Int) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"

        self = formatter.date(from: "\(month)-\(day)-\(year)") ?? Date()
    }
}
