//
//  ChapterMarkerView.swift
//  Gnosis
//
//  Created by Mariangel J. Loaiza Urbina on 2/16/26.
//

import SwiftUI

struct ChapterMarkerView: View {

    enum SideAlignment { case leading, trailing }

    let title: String
    let isCompleted: Bool
    let isCurrent: Bool
    let alignment: SideAlignment

    var body: some View {

        VStack(spacing: 8) {

            Circle()
                .fill(
                    isCompleted
                    ? AppTheme.teal
                    : (isCurrent ? AppTheme.primaryOrange : Color.gray.opacity(0.25))
                )
                .frame(width: 64, height: 64)
                .shadow(color: .black.opacity(0.1), radius: 6, y: 4)

            Text(title)
                .font(.caption.weight(.semibold))
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(.ultraThinMaterial, in: Capsule())
                .frame(maxWidth: 180,
                       alignment: alignment == .leading ? .leading : .trailing)
                .offset(x: alignment == .leading ? -12 : 12)
        }
    }
}
