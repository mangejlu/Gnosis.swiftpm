//
//  ChapterMapView.swift LAYOUT
//  Gnosis
//
//  Created by Mariangel J. Loaiza Urbina on 2/16/26.
//

import SwiftUI

struct ChapterMapView: View {

    let chapters: [Chapter]
    let lastIncompleteIndex: Int

    private let topPadding: CGFloat = 60
    private let spacing: CGFloat = 110

    var body: some View {

        let count = chapters.count
        let totalHeight = topPadding + CGFloat(count - 1) * spacing + 80

        ZStack {
            GeometryReader { geo in
                let points = generatePoints(in: geo.size)

                ZStack {

                    ChapterPathView(points: points)

                    ForEach(Array(points.enumerated()), id: \.offset) { index, point in

                        let chapter = chapters[index]
                        let isCompleted = index < lastIncompleteIndex
                        let isCurrent = index == lastIncompleteIndex

                        if isCompleted || isCurrent {
                            NavigationLink {
                                if index == chapters.count - 1 {
                                    BossIntroView(chapter: chapter)
                                } else {
                                    StoryReaderView(chapter: chapter)
                                }
                            } label: {
                                ChapterMarkerView(
                                    title: chapter.title,
                                    isCompleted: isCompleted,
                                    isCurrent: isCurrent,
                                    alignment: index.isMultiple(of: 2) ? .leading : .trailing
                                )
                            }
                            .buttonStyle(.plain)
                            .position(point)
                        } else {
                            ChapterMarkerView(
                                title: chapter.title,
                                isCompleted: isCompleted,
                                isCurrent: isCurrent,
                                alignment: index.isMultiple(of: 2) ? .leading : .trailing
                            )
                            .opacity(0.5)
                            .position(point)
                        }
                    }
                }
            }
        }
        .frame(height: totalHeight)
    }

    private func generatePoints(in size: CGSize) -> [CGPoint] {

        let centerX = size.width / 2
        let amplitude: CGFloat = size.width * 0.28   // how far left/right
        let waveLength: CGFloat = 2.2                // how tight the curve is

        return (0..<chapters.count).map { i in
            let y = topPadding + CGFloat(i) * spacing
            let progress = CGFloat(i) / waveLength
            let xOffset = sin(progress * .pi) * amplitude

            return CGPoint(
                x: centerX + xOffset,
                y: y
            )
        }
    }
}

