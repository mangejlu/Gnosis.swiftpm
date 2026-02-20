//
//  Chapters.swift
//  Gnosis
//
//  Created by Mariangel J. Loaiza Urbina on 2/13/26.
//

import Foundation

struct Chapter: Codable, Identifiable {
    let id: String
    let title: String
    let content: String
    let highlightedWords: [String: String]
    let quiz: Quiz
}
