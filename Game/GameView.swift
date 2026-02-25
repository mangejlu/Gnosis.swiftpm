
import SwiftUI
import AVFoundation

struct GameView: View {
    let onWin: () -> Void
    private static let maxMonsterHealth = 300
    
    init(onWin: @escaping () -> Void = {}) {
        self.onWin = onWin
    }
    
    @State private var currentRound = 1
    @State private var monsterHealth = GameView.maxMonsterHealth
    @State private var showVictory = false
    @State private var showConfetti = false
    @State private var showAchievement = false
    @State private var feedbackMessage = "Feed me the BLUE FAIRY! 🧚"
    @State private var floatingItems: [FloatingItem] = []
    @State private var itemPositions: [UUID: CGPoint] = [:]
    @State private var draggedItem: FloatingItem?
    @State private var timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    @State private var mouthPosition = CGPoint(x: 200, y: 650)
    
    let rounds = [
        [
            StoryItem(name: "Blue Fairy", emoji: "🧚", isCorrect: true),
            StoryItem(name: "Evil Fairy", emoji: "🧙", isCorrect: false),
            StoryItem(name: "Tooth Fairy", emoji: "🦷", isCorrect: false),
            StoryItem(name: "Fairy Godmother", emoji: "⭐", isCorrect: false),
            StoryItem(name: "Wizard", emoji: "🧙‍♂️", isCorrect: false),
            StoryItem(name: "Magician", emoji: "🪄", isCorrect: false),
            StoryItem(name: "Genie", emoji: "🧞", isCorrect: false),
        ],
        [
            StoryItem(name: "Cricket's Hole", emoji: "🕳️", isCorrect: true),
            StoryItem(name: "Cricket's House", emoji: "🏠", isCorrect: false),
            StoryItem(name: "Spider Web", emoji: "🕸️", isCorrect: false),
            StoryItem(name: "Bird Nest", emoji: "🪹", isCorrect: false),
            StoryItem(name: "Tent", emoji: "⛺️", isCorrect: false),
            StoryItem(name: "Pantheon", emoji: "🏛️", isCorrect: false),
        ],
        [
            StoryItem(name: "Pine Wood", emoji: "🪵", isCorrect: true),
            StoryItem(name: "Sprout", emoji: "🌱", isCorrect: false),
            StoryItem(name: "Cherry Wood", emoji: "🍒", isCorrect: false),
            StoryItem(name: "Maple Wood", emoji: "🍁", isCorrect: false),
            StoryItem(name: "Bamboo", emoji: "🎍", isCorrect: false),
            StoryItem(name: "Branch", emoji: "🌿", isCorrect: false),
            StoryItem(name: "Mushroom", emoji: "🍄", isCorrect: false),
        ],
        [
            StoryItem(name: "Pleasure Island", emoji: "🏝️", isCorrect: true),
            StoryItem(name: "Circus", emoji: "🎪", isCorrect: false),
            StoryItem(name: "Amusement Park", emoji: "🎢", isCorrect: false),
            StoryItem(name: "School", emoji: "🏫", isCorrect: false),
            StoryItem(name: "Playground", emoji: "🛝", isCorrect: false),
            StoryItem(name: "Fair", emoji: "🎡", isCorrect: false),
            StoryItem(name: "Carnival", emoji: "🎠", isCorrect: false),
        ],
        [
            StoryItem(name: "Donkey", emoji: "🫏", isCorrect: true),
            StoryItem(name: "Horse", emoji: "🐴", isCorrect: false),
            StoryItem(name: "Mule", emoji: "🐫", isCorrect: false),
            StoryItem(name: "Pony", emoji: "🐎", isCorrect: false),
            StoryItem(name: "Cow", emoji: "🐮", isCorrect: false),
            StoryItem(name: "Pig", emoji: "🐷", isCorrect: false),
            StoryItem(name: "Sheep", emoji: "🐑", isCorrect: false),
        ]
    ]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                BackgroundView()
                
                if showVictory {
                    ZStack {
                        if showConfetti {
                            ConfettiView()
                                .ignoresSafeArea()
                                .transition(.opacity)
                        }
                        GlassCard {
                            VStack(alignment: .center, spacing: 16) {
                                Text("You Win! 🎉")
                                    .font(.largeTitle.bold())
                                    .frame(maxWidth: .infinity, alignment: .center)

                                if currentRound >= 5 {
                                    Text("The monster is not hungry anymore!")
                                        .font(.headline)
                                        .foregroundColor(AppTheme.secondaryText)
                                } else {
                                    Text("Monster defeated!")
                                        .font(.headline)
                                        .foregroundColor(AppTheme.secondaryText)
                                }
                                
                                // Achievement sticker section
                                VStack(spacing: 12) {
                                    Text("New Sticker Unlocked")
                                        .font(.caption.weight(.semibold))
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(Color.white.opacity(0.25), in: Capsule())
                                        .overlay(
                                            Capsule().stroke(Color.white.opacity(0.35), lineWidth: 1)
                                        )
                                    
                                    VStack(spacing: 8) {
                                        ZStack {
                                            Circle()
                                                .fill(AppTheme.progressGradient)
                                                .frame(width: 120, height: 120)
                                                .overlay(
                                                    Circle().stroke(.white.opacity(0.85), lineWidth: 4)
                                                )
                                                .shadow(color: AppTheme.teal.opacity(0.35), radius: 20, x: 0, y: 10)
                                            
                                            Text("🏝️")
                                                .font(.system(size: 60))
                                        }
                                        
                                        Text("Island Conqueror")
                                            .font(.title3.bold())
                                        
                                        Text("Sticker unlocked for beating your first boss")
                                            .font(.subheadline)
                                            .foregroundColor(AppTheme.secondaryText)
                                    }
                                    .scaleEffect(showAchievement ? 1 : 0.85)
                                    .opacity(showAchievement ? 1 : 0)
                                    .animation(.spring(response: 0.5, dampingFraction: 0.8), value: showAchievement)
                                    
                                    Text("You can see your stickers in the Progress page.")
                                        .font(.footnote)
                                        .foregroundColor(AppTheme.secondaryText)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.top, 4)

                                VStack(spacing: 12) {
                                    Button {
                                        onWin()
                                    } label: {
                                        Text("Continue to last chapter")
                                            .padding()
                                            .frame(maxWidth: .infinity)
                                            .foregroundColor(.white)
                                            .background(AppTheme.progressGradient)
                                            .cornerRadius(25)
                                    }

                                    Button {
                                        resetGame()
                                    } label: {
                                        Text("Play Again")
                                            .padding()
                                            .frame(maxWidth: .infinity)
                                            .background(.ultraThinMaterial)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 25, style: .continuous)
                                                    .stroke(AppTheme.teal.opacity(0.4), lineWidth: 1)
                                            )
                                            .cornerRadius(25)
                                            .foregroundColor(.primary)
                                    }
                                }
                            }
                            .frame(maxWidth: 380)
                        }
                        .padding()
                    }
                    .onAppear {
                        showConfetti = true
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                            showAchievement = true
                        }
                    }
                    
                } else {
                    VStack {
                        // Top bar
                        HStack {
                            Text("Round \(currentRound)/5")
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        .padding()
                        .background(Color.white.opacity(0.8))
                        
                        Text(feedbackMessage)
                            .font(.headline)
                            .padding()
                            .background(Color.black.opacity(0.6))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        
                        Spacer()
                        
                        ZStack {
                            ForEach(floatingItems) { item in
                                Text(item.emoji)
                                    .font(.system(size: 50))
                                    .position(itemPositions[item.id] ?? item.startPosition)
                                    .gesture(
                                        DragGesture()
                                            .onChanged { value in
                                                draggedItem = item
                                                itemPositions[item.id] = value.location
                                            }
                                            .onEnded { _ in
                                                checkIfEaten(item)
                                                draggedItem = nil
                                            }
                                    )
                            }
                            
                            VStack {
                                Spacer()
                                ZStack {
                                    // Monster body
                                    Circle()
                                        .fill(Color.green)
                                        .frame(width: 200, height: 200)
                                        .overlay(
                                            // Eyes
                                            HStack(spacing: 40) {
                                                // Left eye
                                                ZStack {
                                                    Circle()
                                                        .fill(.white)
                                                        .frame(width: 40, height: 40)
                                                    Circle()
                                                        .fill(Double(monsterHealth) / Double(GameView.maxMonsterHealth) > 0.5 ? .black : .red)
                                                        .frame(width: 20, height: 20)
                                                        .offset(
                                                            x: Double(monsterHealth) / Double(GameView.maxMonsterHealth) > 0.5 ? 0 : 5,
                                                            y: Double(monsterHealth) / Double(GameView.maxMonsterHealth) > 0.5 ? 0 : 5
                                                        )
                                                }
                                                
                                                // Right eye
                                                ZStack {
                                                    Circle()
                                                        .fill(.white)
                                                        .frame(width: 40, height: 40)
                                                    Circle()
                                                        .fill(Double(monsterHealth) / Double(GameView.maxMonsterHealth) > 0.5 ? .black : .red)
                                                        .frame(width: 20, height: 20)
                                                        .offset(
                                                            x: Double(monsterHealth) / Double(GameView.maxMonsterHealth) > 0.5 ? 0 : 5,
                                                            y: Double(monsterHealth) / Double(GameView.maxMonsterHealth) > 0.5 ? 0 : 5
                                                        )
                                                }
                                            }
                                            .offset(y: -30)
                                        )
                                    
                                    // Mouth
                                    VStack(spacing: 5) {
                                        Spacer()
                                            .frame(height: 120)
                                        
                                        // Teeth
                                        HStack(spacing: 15) {
                                            ForEach(0..<5, id: \.self) { _ in
                                                Rectangle()
                                                    .fill(.white)
                                                    .frame(width: 15, height: (Double(monsterHealth) / Double(GameView.maxMonsterHealth) > 0.7) ? 20 : 30)
                                                    .overlay(
                                                        Rectangle()
                                                            .stroke(.black, lineWidth: 1)
                                                    )
                                            }
                                        }
                                        
                                        // Tongue
                                        if Double(monsterHealth) / Double(GameView.maxMonsterHealth) < 0.3 {
                                            Rectangle()
                                                .fill(.red)
                                                .frame(width: 100, height: 30)
                                                .cornerRadius(10)
                                                .offset(y: -5)
                                        }
                                    }
                                }
                                .position(x: geometry.size.width / 2, y: geometry.size.height - 120)
                                .onAppear {
                                    mouthPosition = CGPoint(x: geometry.size.width / 2, y: geometry.size.height - 100)
                                }
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            startRound()
        }
        .onReceive(timer) { _ in
            for i in floatingItems.indices {
                if let pos = itemPositions[floatingItems[i].id] {
                    if draggedItem?.id != floatingItems[i].id {
                        itemPositions[floatingItems[i].id] = CGPoint(
                            x: pos.x,
                            y: pos.y + sin(Date().timeIntervalSince1970 + Double(i)) * 0.5
                        )
                    }
                }
            }
        }
    }
    
    func startRound() {
        floatingItems.removeAll()
        itemPositions.removeAll()
        
        let round = rounds[currentRound - 1]
        let roundItems = round.shuffled().prefix(7)
        
        for item in roundItems {
            let x = CGFloat.random(in: 50...350)
            let y = CGFloat.random(in: 150...450)
            let newItem = FloatingItem(
                id: UUID(),
                emoji: item.emoji,
                isCorrect: item.isCorrect,
                startPosition: CGPoint(x: x, y: y)
            )
            floatingItems.append(newItem)
            itemPositions[newItem.id] = newItem.startPosition
        }
        
        switch currentRound {
        case 1:
            feedbackMessage = "Feed me the character who made Pinocchio real! "
        case 2:
            feedbackMessage = "Feed me the talking cricket's home!"
        case 3:
            feedbackMessage = "Feed me what Pinocchio was carved from!"
        case 4:
            feedbackMessage = "Feed me the place where boys turned into donkeys!"
        case 5:
            feedbackMessage = "Feed me what the bad boys became!"
        default:
            feedbackMessage = "Feed me the correct items!"
        }
    }
    
    func checkIfEaten(_ item: FloatingItem) {
        guard let pos = itemPositions[item.id] else { return }
        
        let distance = sqrt(pow(pos.x - mouthPosition.x, 2) + pow(pos.y - mouthPosition.y, 2))
        
        if distance < 80 {
            if item.isCorrect {
                // Correct item
                monsterHealth -= 20
                feedbackMessage = "YUM! 😋"
                
                // Remove the eaten item
                floatingItems.removeAll { $0.id == item.id }
                itemPositions.removeValue(forKey: item.id)
                
                // Check if monster is defeated
                if monsterHealth <= 0 {
                    monsterHealth = 0
                    showVictory = true
                    return
                }
                
                // Check if all correct items are gone
                let correctItemsRemaining = floatingItems.contains { $0.isCorrect }
                if !correctItemsRemaining {
                    // Move to next round
                    if currentRound < 5 {
                        currentRound += 1
                        startRound()
                    } else {
                        showVictory = true
                    }
                }
            } else {
                // Wrong item
                monsterHealth = min(monsterHealth + 5, GameView.maxMonsterHealth)
                feedbackMessage = "YUCK! Wrong item! 😝"
                
                withAnimation {
                    itemPositions[item.id] = item.startPosition
                }
            }
        } else {
            withAnimation {
                itemPositions[item.id] = item.startPosition
            }
        }
    }
    
    func resetGame() {
        currentRound = 1
        monsterHealth = GameView.maxMonsterHealth
        showVictory = false
        startRound()
    }
}

struct FloatingItem: Identifiable {
    let id: UUID
    let emoji: String
    let isCorrect: Bool
    let startPosition: CGPoint
}

struct StoryItem {
    let name: String
    let emoji: String
    let isCorrect: Bool
}

#Preview {
    GameView()
}

