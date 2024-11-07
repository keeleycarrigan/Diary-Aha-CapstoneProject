//
//  Entry.swift
//  DiaryAha
//
//  Created by Keeley Carrigan on 10/14/24.
//

import Foundation
import SwiftUI

protocol MediaFile: Identifiable, Hashable {
    associatedtype MediaType: Hashable

    var displayName: String { get }
    var mediaFile: MediaType { get }
}

struct Entry: Identifiable, Equatable {
    let id: UUID = .init()
    var title: String
    var body: String
    var date: Date
    var vibe: VibeImages
    var photos: [PhotoMedia] = []
}

extension Entry {
    struct PhotoMedia: MediaFile, Transferable {
        let id = UUID()
        let displayName: String
        let mediaFile: UIImage

        var mediaImage: Image {
            Image(uiImage: mediaFile)
        }

        static var transferRepresentation: some TransferRepresentation {
            DataRepresentation(exportedContentType: .image) { (photo: PhotoMedia) -> Data in
                guard let imageData = photo.mediaFile.pngData() else {
                    throw EntryErrors.invalidImage
                }
                return imageData
            }
        }
    }

}
