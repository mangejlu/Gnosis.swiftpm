//
//  ChapterPathView.swift
//  Gnosis
//
//  Created by Mariangel J. Loaiza Urbina on 2/16/26.
//


import SwiftUI

struct ChapterPathShape: Shape {

    let points: [CGPoint]

    func path(in rect: CGRect) -> Path {

        guard points.count > 1 else { return Path() }

        var path = Path()
        path.move(to: points[0])

        for i in 0..<points.count - 1 {

            let p0 = points[i]
            let p1 = points[i + 1]

            let mid = CGPoint(
                x: (p0.x + p1.x) / 2,
                y: (p0.y + p1.y) / 2
            )

            path.addQuadCurve(to: mid, control: p0)
            path.addQuadCurve(to: p1, control: p1)
        }

        return path
    }
}


struct ChapterPathView: View {

    let points: [CGPoint]

    var body: some View {
        ChapterPathShape(points: points)
            .stroke(
                AppTheme.teal.opacity(0.25),
                style: StrokeStyle(
                    lineWidth: 6,
                    lineCap: .round,
                    lineJoin: .round,
                    dash: [8, 10]
                )
            )
    }
}
