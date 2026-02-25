

import Foundation

struct Chapter: Codable, Identifiable {
    let id: String
    let title: String
    let content: String
    let highlightedWords: [String: String]
    let quiz: Quiz
}
