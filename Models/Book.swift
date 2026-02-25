
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
