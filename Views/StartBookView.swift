import SwiftUI

struct StartBookView: View {
    let onFinished: () -> Void
    @State private var currentIndex = 0

    init(onFinished: @escaping () -> Void = {}) {
        self.onFinished = onFinished
    }

    var body: some View {
        ZStack {
            VStack {
                StartBookSinglePageView(currentIndex: $currentIndex, onFinished: onFinished)
            }
        }
        .background(BackgroundView())
    }
}


struct StartBookSinglePageView: View {
    @Binding var currentIndex: Int
    let onFinished: () -> Void

    @State private var isFlipping = false
    @State private var flipAngle: Double = 0
    @State private var flipDirection: FlipDirection = .forward
    @State private var pendingIndex: Int? = nil

    private enum FlipDirection { case forward, backward }

    private var pageCount: Int { pages.count }

    private var pages: [AnyView] {
        [
            AnyView(pageWelcome),
            AnyView(pageCreator),
            AnyView(pageApp),
            AnyView(pageWhy),
            AnyView(pageHow),
            AnyView(pageHow2),
        ]
    }

    var body: some View {
        VStack(spacing: 0) {
            bookHeader

            Spacer(minLength: 8)

            ZStack {
                if isFlipping {
                    if flipDirection == .forward, let dest = pendingIndex, dest < pageCount {
                        pageFrame { pages[dest] }
                    } else {
                        pageFrame { pages[currentIndex] }
                    }
                } else {
                    pageFrame { pages[currentIndex] }
                }

                if isFlipping {
                    flippingOverlay
                }
            }
            .contentShape(Rectangle())
            .gesture(pageSwipeGesture)

            navigationBar
                .padding(.top, 16)
        }
        .padding(.horizontal, 20)
    }

    private var bookHeader: some View {
        HStack {

            Spacer()

            Text("Page \(currentIndex + 1)/\(pageCount)")
                .font(.system(size: 14, design: .serif))
                .foregroundColor(AppTheme.secondaryText)
        }
        .padding(.horizontal, 10)
        .padding(.top, 20)
    }

    // styling
    private func pageFrame<Content: View>(@ViewBuilder _ content: () -> Content) -> some View {
        let pageWidth = min(UIScreen.main.bounds.width * 0.9, 560)
        let pageHeight = min(UIScreen.main.bounds.height * 0.75, 600)
        return VStack { content() }
            .padding(18)
            .frame(width: pageWidth, height: pageHeight)
            .background(
                AppTheme.paperGradient
            )
            .overlay(alignment: .leading) {
                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: [Color.black.opacity(0.06), .clear],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: 10)
                    .blur(radius: 0.3)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color.gray.opacity(0.15), lineWidth: 1)
            )
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            .shadow(color: .black.opacity(0.1), radius: 12, x: 0, y: 8)
    }

    // flipping
    private var flippingOverlay: some View {
        let anchor: UnitPoint = .leading
        let pageWidth = min(UIScreen.main.bounds.width * 0.9, 560)
        let pageHeight = min(UIScreen.main.bounds.height * 0.75, 600)
        let progress = min(1, abs(flipAngle) / 180)

        let gradientStart: UnitPoint = (flipDirection == .forward) ? .trailing : .leading
        let gradientEnd: UnitPoint = (flipDirection == .forward) ? .leading : .trailing
        let shadowX: CGFloat = (flipDirection == .forward) ? -6 : 6

        return ZStack {
            ZStack {
                if abs(flipAngle) < 90 {
                    pageFrame { pages[currentIndex] }
                } else {
                    pageFrame { pages[pendingIndex ?? currentIndex] }
                        .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
                }
            }
            .frame(width: pageWidth, height: pageHeight)
            .rotation3DEffect(
                .degrees(flipAngle),
                axis: (x: 0, y: 1, z: 0),
                anchor: anchor,
                perspective: 0.9
            )
            .overlay(
                LinearGradient(
                    colors: [Color.black.opacity(0.18 * progress), Color.clear],
                    startPoint: gradientStart,
                    endPoint: gradientEnd
                )
                .blendMode(.multiply)
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            )
            .shadow(color: .black.opacity(0.25 * progress), radius: 12, x: shadowX, y: 10)
        }
    }
    // Navigation
    private var navigationBar: some View {
        HStack {
            Button(action: previousPage) {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(currentIndex > 0 ? .black : .gray.opacity(0.5))
                    .padding()
                    .background(
                        Circle().fill(Color.white)
                            .shadow(color: .black.opacity(0.15), radius: 6, x: 0, y: 3)
                    )
            }
            .disabled(currentIndex == 0 || isFlipping)

            Spacer()

            Button(action: nextPage) {
                Image(systemName: "chevron.right")
                    .font(.title2)
                    .foregroundColor(currentIndex < pageCount - 1 ? .black : .gray.opacity(0.5))
                    .padding()
                    .background(
                        Circle().fill(Color.white)
                            .shadow(color: .black.opacity(0.15), radius: 6, x: 0, y: 3)
                    )
            }
            .disabled(currentIndex >= pageCount - 1 || isFlipping)
        }
        .padding(.horizontal, 30)
    }

    private var pageSwipeGesture: some Gesture {
        DragGesture(minimumDistance: 20)
            .onEnded { value in
                guard !isFlipping else { return }
                if value.translation.width < -60 {
                    nextPage()
                } else if value.translation.width > 60 {
                    previousPage()
                }
            }
    }

    private func nextPage() {
        guard currentIndex < pageCount - 1, !isFlipping else { return }
        flipDirection = .forward
        pendingIndex = currentIndex + 1
        isFlipping = true
        flipAngle = 0
        withAnimation(.easeInOut(duration: 0.6)) {
            flipAngle = -180
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            currentIndex = pendingIndex ?? currentIndex
            pendingIndex = nil
            isFlipping = false
            flipAngle = 0
        }
    }

    private func previousPage() {
        guard currentIndex > 0, !isFlipping else { return }
        currentIndex -= 1
    }}

// Page Contents
private extension StartBookSinglePageView {
    var pageWelcome: some View {
        VStack(spacing: 14) {
            Spacer()
            Image(systemName: "sparkles")
                .font(.system(size: 42))
                .foregroundColor(AppTheme.sunshine)
                .padding(.bottom, 8)

            Text("Welcome to")
                .font(.system(size: 18, design: .serif))
                .foregroundColor(.gray)

            Text("GNOSIS")
                .font(.system(size: 42, weight: .bold, design: .serif))
                .foregroundColor(.black)

            Rectangle()
                .fill(AppTheme.sunshine.opacity(0.3))
                .frame(width: 110, height: 2)
                .padding(.vertical, 6)

            Text("Open Me!")
                .font(.system(size: 15, design: .serif))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)

            Spacer()
            HStack(spacing: 6) {
                Image(systemName: "hand.draw")
                Text("Swipe to continue")
            }
            .font(.footnote)
            .foregroundColor(.gray)
        }
    }

    var pageCreator: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top, spacing: 12) {
                Text("Meet the Creator!")
                    .font(.system(size: 35, weight: .bold, design: .serif))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)

                RoundedRectangle(cornerRadius: 14)
                    .fill(Color.gray.opacity(0.08))
                    .frame(width: 120, height: 140)
                    .overlay(
                        Image("Memoji")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 140)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                    )
            }

            VStack(alignment: .leading, spacing: 8) {

                Text("Hi!👋 My name is Mariangel Loaiza, I'm a Computer Engineering student at Tecnológico de Monterrey. I adore the arts in all their forms and I'm constantly looking for ways to intersect creativity with technology.  ")
                    .font(.system(size: 19, design: .serif))
                    .foregroundColor(.gray)
                    .lineSpacing(4)

                Text("Reading has always been meaningful to me. My dad taught me to read before elementary school so we could share fairytales together before bed. Since then, I haven't stopped. ")
                    .font(.system(size: 19, design: .serif))
                    .foregroundColor(.gray)
                    .lineSpacing(4)
                    .padding(.top, 8)
            }
        }
    }

    var pageApp: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("The App: Gnosis")
                .font(.system(size: 35, weight: .bold, design: .serif))
                .foregroundColor(.black)

            Text("Gnosis is a gamified reading app designed to help young readers discover the joy of books while building focus and literacy skills. Gnosis combats the cognitive fragmentation caused by short-form content, making every finished book feel like a victory.")
                .font(.system(size: 18, design: .serif))
                .foregroundColor(.gray)
                .lineSpacing(4)

            Text("Frameworks")
                .font(.system(size: 30, weight: .bold, design: .serif))
                .foregroundColor(.black)
                .padding(.top, 2)
  
                VStack(alignment: .leading, spacing: 12) {
                    StartBookFeatureRow(icon: "bolt.fill", text: "AVFoundations")
                    StartBookFeatureRow(icon: "bolt.fill", text: "SwiftUI")
                    StartBookFeatureRow(icon: "bolt.fill", text: "Foundation")
                    StartBookFeatureRow(icon: "bolt.fill", text: "Combine")
                    StartBookFeatureRow(icon: "bolt.fill", text: "UIKit")

                }
                    
            
            .font(.system(size:18, design: .serif))
        }
    }

    var pageWhy: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Why Books? 🤔📚")
                .font(.system(size: 30, weight: .bold, design: .serif))
                .foregroundColor(.black)

            Text("Books are where children learn to think, not just consume. Kids who read have bigger vocabularies, stronger focus, deeper emotional intelligence, and better academic outcomes.  Every child deserves the chance to build those foundations before the algorithm trains them to scroll instead of wonder.")
                .font(.system(size: 18, design: .serif))
                .foregroundColor(.gray)
                .lineSpacing(4)
            


        }
    }
    
    var pageHow: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("The Magic 🪄✨")
                .font(.system(size: 30, weight: .bold, design: .serif))
                .foregroundColor(.black)

            Text("Kids explore story “islands,” unlock chapters, and face playful boss challenges that make finishing a book feel like a win. Along the way, quick quizzes and friendly vocabulary helpers build confidence without pressure, while streaks and gentle rewards keep momentum going. This makes focus feel fun and progress be trackable.")
                .font(.system(size: 18, design: .serif))
                .foregroundColor(.gray)
                .lineSpacing(4)

        }
    }


    var pageHow2: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            Text("Guide 🗺️")
                .font(.system(size: 30, weight: .bold, design: .serif))
                .foregroundColor(.black)

            Text("For this demo, most levels are already unlocked, except for the final one. To unlock the last boss chapter and take on the Isle of Honesty, you’ll need to complete the chapter that’s glowing orange. Once you finish that chapter, the next one in the sequence (the final chapter) will then be highlighted the same way, so you can always clearly see which chapter you’re on. If you ever want to revisit earlier chapters, those are fully open and ready to play! Dont forget to check out your progress and click on new words to learn more about them.")
                .font(.system(size: 18, design: .serif))
                .foregroundColor(.gray)
                .lineSpacing(4)

                        
            Button(action: {
                withAnimation(.spring()) {
                    onFinished()
                }
            }) {
                Text("Let's Dive In!")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 12)
                    .background(AppTheme.progressGradient)
                    .cornerRadius(25)
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 3, y: 3)
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }

    
    }

}

struct StartBookFeatureRow: View {
    let icon: String
    let text: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(AppTheme.sunshine)
                .frame(width: 24)

            Text(text)
                .font(.system(size: 18, design: .serif))
                .foregroundColor(.gray)
                

            Spacer()
        }
    }
}

#Preview {
    StartBookView()
}

