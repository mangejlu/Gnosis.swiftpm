//
//  ProgressBarView.swift
//  Gnosis
//
//  Created by Mariangel J. Loaiza Urbina on 2/15/26.
//

import SwiftUI

struct ProgressBarView: View {
    var progress: Double
    var height: CGFloat = 12

    init(progress: Double) {
        self.progress = progress
        self.height = 12
    }

    init(progress: Double, height: CGFloat) {
        self.progress = progress
        self.height = height
    }

    var body: some View {
        let clamped = max(0, min(progress, 1))
        GeometryReader { geo in
            let inset: CGFloat = 3
            ZStack(alignment: .leading) {
                // Track
                RoundedRectangle(cornerRadius: height / 2, style: .continuous)
                    .fill(Color.white.opacity(0.95))
                    .overlay(
                        RoundedRectangle(cornerRadius: height / 2, style: .continuous)
                            .stroke(Color.black.opacity(0.06), lineWidth: 1)
                    )

                // Fill
                RoundedRectangle(cornerRadius: height / 2, style: .continuous)
                    .fill(AppTheme.progressGradient)
                    .frame(width: max(0, (geo.size.width - inset * 2) * clamped))
                    .padding(.horizontal, inset)
                    .shadow(color: Color.orange.opacity(0.18), radius: 4, x: 0, y: 1)
                    .animation(.easeInOut(duration: 0.35), value: clamped)
            }
        }
        .frame(height: height)
        .accessibilityLabel("Progress")
        .accessibilityValue(Text("\(Int(max(0, min(progress, 1)) * 100)) percent"))
    }
}
#Preview {
    VStack(spacing: 16) {
        ProgressBarView(progress: 0.2)
        ProgressBarView(progress: 0.6, height: 16)
        ProgressBarView(progress: 0.9)
    }
    .padding()
    .background(BackgroundView())
}

