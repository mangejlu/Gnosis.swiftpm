import SwiftUI

struct BossIntroView: View {
    let chapter: Chapter

    @State private var showGame = false
    @State private var goToFinalChapter = false

    var body: some View {
        ZStack {
            BackgroundView()

            ScrollView {
                VStack(spacing: 24) {
                    HStack(spacing: 10) {
                        Text("👾")
                            .font(.largeTitle)
                        Text("Final Challenge")
                            .font(.title.bold())
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    GlassCard {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Oh no! The monster is about to eat the last chapter! We must do something about it. Let's feed it something else!")
                                .font(.headline)
                            Text("Feed the monster to unlock \(chapter.title).")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    Button {
                        showGame = true
                    } label: {
                        Text("Feed the Monster")
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
        .fullScreenCover(isPresented: $showGame) {
            GameView(onWin: {
                showGame = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    goToFinalChapter = true
                }
            })
        }
        .navigationDestination(isPresented: $goToFinalChapter) {
            StoryReaderView(chapter: chapter)
        }
        .navigationTitle("Boss Battle")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    if let chapter = LocalData.books.first?.chapters.last {
        BossIntroView(chapter: chapter)
    }
}
