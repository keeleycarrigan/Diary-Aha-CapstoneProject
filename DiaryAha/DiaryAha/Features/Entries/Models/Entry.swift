//
//  Entry.swift
//  DiaryAha
//
//  Created by Keeley Carrigan on 10/14/24.
//

import Foundation
import SwiftData

@Model
final class Entry: Codable, Hashable {
    enum CodingKeys: CodingKey {
        case id
        case title
        case body
        case date
        case vibe
        case photos
        case hasPhotos
    }

    var id: UUID
    var title: String
    var body: String
    var date: Date
    var vibe: VibeImages
    var hasPhotos: Bool { !photos.isEmpty }

    @Attribute(.externalStorage)
    var photos: [Data]

    init(title: String, body: String, date: Date, vibe: VibeImages, photos: [Data] = []) {
        self.id = UUID()
        self.title = title
        self.body = body
        self.date = date
        self.vibe = vibe
        self.photos = photos
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(UUID.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        body = try container.decode(String.self, forKey: .body)
        date = try container.decode(Date.self, forKey: .date)
        vibe = try container.decode(VibeImages.self, forKey: .vibe)
        photos = try container.decode([Data].self, forKey: .photos)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(body, forKey: .body)
        try container.encode(date, forKey: .date)
        try container.encode(vibe, forKey: .vibe)

        if !photos.isEmpty {
            try container.encode(photos, forKey: .photos)
        }
    }
}
