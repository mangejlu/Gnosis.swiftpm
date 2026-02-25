

import SwiftUI

struct BookCompletionView: View {
    var onClose: (() -> Void)?

    @State private var showConfetti = false

    var body: some View {
        ZStack {
            BackgroundView()

            ScrollView {
                VStack(spacing: 24) {
                    HStack(spacing: 10) {
                        Text("🏆")
                            .font(.largeTitle)
                        Text("Book Completed!")
                            .font(.title.bold())
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    if showConfetti {
                        ConfettiView()
                            .frame(height: 160)
                    }

                    GlassCard {
                        VStack(spacing: 16) {
                            Text("Sticker Unlocked!")
                                .font(.headline)
                                .foregroundStyle(.primary)
                            
                            StickerBadgeView(icon: "📚", title: "Bookworm")
                                .frame(width: 200, height: 200)

                            Text("You can see your stickers in the Progress page.")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: .infinity)
                    }

                    Button {
                        onClose?()
                    } label: {
                        Text("Done")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(AppTheme.progressGradient)
                            .cornerRadius(25)
                    }
                }
                .padding()
            }
        }
        .onAppear { showConfetti = true }
        .interactiveDismissDisabled(true)
    }
}

#Preview {
    BookCompletionView(onClose: {})
}
