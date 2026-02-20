import SwiftUI

struct StickerBadgeView: View {
    let icon: String
    let title: String

    var body: some View {
        GeometryReader { proxy in
            let size = min(proxy.size.width, proxy.size.height)
            ZStack {
                Circle()
                    .stroke(AppTheme.progressGradient, lineWidth: size * 0.10)
                    .shadow(color: .black.opacity(0.15), radius: size * 0.08, y: size * 0.04)

                Circle()
                    .fill(Color.white)
                    .padding(size * 0.10)
                    .shadow(color: .black.opacity(0.06), radius: size * 0.06, y: size * 0.02)

                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color.white.opacity(0.6), Color.white.opacity(0.15), .clear],
                            startPoint: .top,
                            endPoint: .center
                        )
                    )
                    .padding(size * 0.10)
                    .opacity(0.8)

                Text(icon)
                    .font(.system(size: size * 0.42))
                    .minimumScaleFactor(0.5)
                    .frame(width: size * 0.6, height: size * 0.6)
            }
            .overlay(alignment: .bottom) {
                Text(title)
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 6)
                    .background(
                        Capsule()
                            .fill(AppTheme.progressGradient)
                            .shadow(color: .black.opacity(0.12), radius: size * 0.06, y: size * 0.03)
                    )
                    .offset(y: size * 0.06)
            }
        }
    }
}

#Preview {
    VStack(spacing: 24) {
        StickerBadgeView(icon: "🏝️", title: "Island Conqueror")
            .frame(width: 180, height: 180)
        StickerBadgeView(icon: "🐛", title: "Bookworm")
            .frame(width: 160, height: 160)
    }
    .padding()
    .background(BackgroundView())
}
