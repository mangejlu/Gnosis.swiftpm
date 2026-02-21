//
//  ChaptersMapView.swift SCREEN
//  Gnosis
//
//  Created by Mariangel J. Loaiza Urbina on 2/13/26.
//

import SwiftUI

struct ChaptersMapView: View {

    let book: Book
    @EnvironmentObject private var progressStore: ProgressStore

    var body: some View {
        let chapters = book.chapters
        let progress = min(max(progressStore.progress(for: book), 0), chapters.count)
        let completedCount = min(progress, chapters.count)
        let lastIncompleteIndex = min(progress, max(0, chapters.count - 1))

        ZStack {
            BackgroundView()

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 28) {

                    // Header
                    VStack(spacing: 6) {
                        Text(book.islandName)
                            .font(.largeTitle.bold())

                        Text("\(completedCount)/\(chapters.count) completed")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.top, 12)

                    // Map
                    GlassCard {
                        ChapterMapView(
                            chapters: chapters,
                            lastIncompleteIndex: lastIncompleteIndex
                        )
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 40)
            }
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

