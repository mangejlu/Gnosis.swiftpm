//
//  Book.swift
//  Gnosis
//
//  Created by Mariangel J. Loaiza Urbina on 2/13/26.
//

import Foundation

struct Book: Codable, Identifiable {
    let id: String
    let title: String
    let subtitle: String
    let islandName: String
    let isLocked: Bool
    let progress: Int
    let chapters: [Chapter]
}
