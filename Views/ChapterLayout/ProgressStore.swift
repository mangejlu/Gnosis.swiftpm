import Foundation
import SwiftUI

final class ProgressStore: ObservableObject {
    @Published private(set) var progressByBook: [String: Int] = [:]

    init() {
        // Seed with initial progress from LocalData
        for book in LocalData.books {
            progressByBook[book.id] = book.progress
        }
    }

    func progress(for book: Book) -> Int {
        progressByBook[book.id] ?? 0
    }

    func setProgress(_ newValue: Int, for book: Book, totalChapters: Int) {
        let clamped = max(0, min(newValue, totalChapters))
        if progressByBook[book.id] != clamped {
            progressByBook[book.id] = clamped
        }
    }

    func incrementProgress(for book: Book, totalChapters: Int) {
        let current = progress(for: book)
        setProgress(current + 1, for: book, totalChapters: totalChapters)
    }
}
