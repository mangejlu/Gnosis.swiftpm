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

        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 28) {

                // Map
                ChapterMapView(
                    chapters: chapters,
                    lastIncompleteIndex: lastIncompleteIndex
                )
            }
            .padding(.horizontal)
            .padding(.bottom, 40)
            .frame(maxWidth: .infinity)
            .background(
                Image("MapBackround")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .accessibilityHidden(true)
            )
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

