//
//  ProgressRing.swift
//  Gnosis
//
//  Created by Mariangel J. Loaiza Urbina on 2/13/26.
//

import SwiftUI

struct ProgressRing: View {

    var progress: Double

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.white.opacity(0.3), lineWidth: 12)

            Circle()
                .trim(from: 0, to: progress)
                .stroke(AppTheme.progressGradient,
                        style: StrokeStyle(lineWidth: 12, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut, value: progress)

            Text("\(Int(progress * 100))%")
                .font(.headline)
        }
        .frame(width: 100, height: 100)
    }
}
