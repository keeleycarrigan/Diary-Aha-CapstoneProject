//
//  Entry.swift
//  DiaryAha
//
//  Created by Keeley Carrigan on 10/14/24.
//

import Foundation

struct Entry: Hashable, Identifiable {
    var id: UUID = .init()
    var title: String
    var body: String
    var date: Date
    // TODO: - update value type
    var vibe: String
    var photos: [String] = []
}
