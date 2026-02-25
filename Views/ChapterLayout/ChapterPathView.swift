
import SwiftUI

struct ChapterPathShape: Shape {

    let points: [CGPoint]

    func path(in rect: CGRect) -> Path {

        guard points.count > 1 else { return Path() }

        var path = Path()
        path.move(to: points[0])

        for i in 1..<points.count {
            let prev = points[i - 1]
            let current = points[i]
            
            let mid = CGPoint(
                x: (prev.x + current.x) / 2,
                y: (prev.y + current.y) / 2
            )
            
            path.addQuadCurve(to: mid, control: prev)
            path.addQuadCurve(to: current, control: current)
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
