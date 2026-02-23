import SwiftUI

struct ProgressViewScreen: View {

    struct Skill: Identifiable {
        let id = UUID()
        let name: String
        let color: Color
        let progress: Double
        let emoji: String
    }

    private let skills: [Skill] = [
        .init(name: "Comprehension", color: AppTheme.primaryOrange, progress: 0.72, emoji: "📖"),
        .init(name: "Vocabulary", color: AppTheme.teal, progress: 0.58, emoji: "🔤"),
        .init(name: "Critical Thinking", color: .pink, progress: 0.45, emoji: "🧠")
    ]

    private let stickers: [Sticker] = Sticker.sample

    var body: some View {
        ZStack {
            BackgroundView()

            ScrollView {
                VStack(alignment: .leading, spacing: 22) {

                    HStack(spacing: 10) {
                        Text("📊")
                        Text("My Skills")
                            .font(.title2.bold())
                            .foregroundColor(.black)
                        Spacer()
                    }
                    .padding(.horizontal)

                    // Skill Cards
                    VStack(spacing: 14) {
                        ForEach(skills) { skill in
                            SkillProgressCard(skill: skill)
                                .padding(.horizontal)
                                
                        }
                    }
                    .padding(.bottom, 8)

                    HStack(spacing: 10) {
                        Text("🏅")
                        Text("Sticker Collection")
                            .font(.title3.bold())
                            .foregroundColor(.black)
                        Spacer()
                    }
                    .padding(.horizontal)

                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        ForEach(stickers) { sticker in
                            StickerTile(sticker: sticker)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 28)
                }
                .padding(.top, 20)
            }
        }
    }
}

// Skill
private struct SkillProgressCard: View {
    let skill: ProgressViewScreen.Skill

    var body: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    HStack(spacing: 8) {
                        Text(skill.emoji).font(.title3)
                        Text(skill.name)
                            .font(.headline)
                            .foregroundColor(.black)
                    }
                    Spacer()
                    Text("\(Int(skill.progress * 100))%")
                        .font(.subheadline.bold())
                        .foregroundColor(.black)
                }

                ProgressBarView(progress: skill.progress, height: 14)
            }
            .frame(minHeight: 72)
        }
    }
}

struct Sticker: Identifiable {
    let id = UUID()
    let title: String
    let systemImage: String
    let earned: Bool

    static let sample: [Sticker] = [
        .init(title: "First Story", systemImage: "star.fill", earned: true),
        .init(title: "7-Day Streak", systemImage: "flame.fill", earned: true),
        .init(title: "Bookworm", systemImage: "book.fill", earned: false),
        .init(title: "Quiz Master", systemImage: "medal.fill", earned: false),
        .init(title: "Island Conqueror", systemImage: "globe.americas.fill", earned: false),
        .init(title: "Perfectionist", systemImage: "rosette", earned: false)
    ]
}

private struct StickerTile: View {
    let sticker: Sticker

    var body: some View {
        VStack(spacing: 8) {
            ZStack(alignment: .topTrailing) {
                GlassCard {
                    VStack {
                        Image(systemName: sticker.systemImage)
                            .font(.title2)
                            .foregroundStyle(.black)
                    }
                    .frame(width: 64, height: 64)
                }
                .opacity(sticker.earned ? 1 : 0.7)

                if !sticker.earned {
                    Image(systemName: "lock.fill")
                        .font(.caption2)
                        .foregroundStyle(.black)
                        .padding(6)
                        .background(.ultraThinMaterial, in: Circle())
                        .offset(x: 6, y: -6)
                }
            }

            HStack(spacing: 4) {
                Image(systemName: "star.fill")
                    .foregroundStyle(sticker.earned ? Color.yellow : Color.gray.opacity(0.4))
                    .font(.caption)
                Text(sticker.title)
                    .font(.footnote)
                    .foregroundColor(.black)
                    .lineLimit(1)
            }
        }
    }
}

#Preview {
    ProgressViewScreen()
}

