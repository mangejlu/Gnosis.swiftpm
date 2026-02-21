//
//  ChaptersMapView.swift SCREEN
//  Gnosis
//
//  Created by Mariangel J. Loaiza Urbina on 2/13/26.
//

import SwiftUI

struct ChaptersMapView: View {

    let book: Book

    var body: some View {
        let chapters = book.chapters
        let lastIndex = max(0, chapters.count - 1)
        let completedCount = max(0, chapters.count - 1)

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
                            lastIncompleteIndex: lastIndex
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

