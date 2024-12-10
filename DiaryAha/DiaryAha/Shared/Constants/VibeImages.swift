//
//  Images.swift
//  DiaryAha
//
//  Created by Keeley Carrigan on 10/24/24.
//

import Foundation

enum VibeImages: String, CaseIterable, Identifiable, Codable {
    case angry = "AngryVibe"
    case anxious = "AnxiousVibe"
    case happy = "HappyVibe"
    case sad = "SadVibe"
    case tired = "TiredVibe"

    var id: String { self.rawValue }
}
