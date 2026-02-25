
import SwiftUI

struct ChapterMarkerView: View {

    enum SideAlignment { case leading, trailing }

    let title: String
    let isCompleted: Bool
    let isCurrent: Bool
    let alignment: SideAlignment

    @State private var pulse = false

    var body: some View {

        VStack(spacing: 8) {

            ZStack {
                Image("ChapterIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 64, height: 64)

                Circle()
                    .stroke(
                        isCompleted
                        ? AppTheme.teal
                        : (isCurrent ? AppTheme.primaryOrange : Color.gray.opacity(0.25)),
                        lineWidth: 4
                    )
                    .frame(width: 64, height: 64)
            }
            .shadow(color: .black.opacity(0.1), radius: 6, y: 4)
            .scaleEffect(
                isCurrent ? (pulse ? 1.15 : 0.95) : 1
            )
            .onAppear {
                guard isCurrent else { return }
                pulse = false
                withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                    pulse = true
                }
            }
            .onChange(of: isCurrent) { newValue in
                if newValue {
                    pulse = false
                    withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                        pulse = true
                    }
                } else {
                    pulse = false
                }
            }

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

