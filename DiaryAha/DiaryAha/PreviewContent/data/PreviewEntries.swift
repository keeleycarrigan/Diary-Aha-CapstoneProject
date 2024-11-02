//
//  Entries.swift
//  DiaryAha
//
//  Created by Keeley Carrigan on 10/17/24.
//

import Foundation

extension Entry {
    static var previewEntries: [Entry] = [
        Entry(
            title: "First Entry",
            body: "Body",
            date: Date(month: 10, day: 17, year: 2024),
            vibe: VibeImages.happy
        ),
        Entry(
            title: "Godzilla Attacked!",
            body: "Body",
            date: Date(month: 10, day: 18, year: 2024),
            vibe: VibeImages.angry
        ),
        Entry(
            title: "Now Mothra is getting involved",
            body: "Body",
            date: Date(month: 11, day: 2, year: 2024),
            vibe: VibeImages.sad
        ),
        Entry(
            title: "I Saw a Floating Baby Godzilla",
            body: "Body",
            date: Date(month: 11, day: 4, year: 2024),
            vibe: VibeImages.tired
        )
    ]
}
