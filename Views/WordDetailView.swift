//
//  WordDetailView.swift
//  Gnosis
//
//  Created by Mariangel J. Loaiza Urbina on 2/23/26.
//

import SwiftUI
import AVFoundation

struct WordDetailView: View {
    let word: String
    let definition: String
    let syllables: String?
    @Binding var isPresented: Bool
    
    @State private var speechSynthesizer = AVSpeechSynthesizer()
    @State private var isSpeaking = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 24) {
                HStack {
                    HStack(spacing: 8) {
                        Text("New Word!")
                    }
                    .font(.title3.bold())
                    .foregroundColor(.black)
                    
                    Spacer()
                    
                    Button(action: dismiss) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundColor(.black.opacity(0.6))
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 8)
                
                VStack(spacing: 8) {
                    Text(word.capitalized)
                        .font(.largeTitle.bold())
                        .foregroundColor(.black)
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                    
                    // Syllables (if available)
                    if let syllables = syllables {
                        Text(syllables)
                            .font(.subheadline)
                            .foregroundColor(.black)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Capsule().fill(Color.white.opacity(0.8)))
                            .overlay(
                                Capsule()
                                    .stroke(AppTheme.teal.opacity(0.6), lineWidth: 1)
                            )
                    }
                }
                .padding(.horizontal, 24)
                
                // Listen button
                Button(action: speakWord) {
                    HStack(spacing: 16) {
                        ZStack {
                            Image(systemName: "speaker.wave.2.fill")
                                .font(.title)
                                .opacity(isSpeaking ? 0 : 1)
                            
                            if isSpeaking {
                                HStack(spacing: 3) {
                                    ForEach(0..<4) { i in
                                        RoundedRectangle(cornerRadius: 2)
                                            .frame(width: 4, height: 15 + CGFloat(i * 5))
                                            .animation(
                                                Animation.easeInOut(duration: 0.5)
                                                    .repeatForever()
                                                    .delay(Double(i) * 0.15),
                                                value: isSpeaking
                                            )
                                    }
                                }
                                .foregroundColor(.white)
                            }
                        }
                        
                        Text(isSpeaking ? "Playing..." : "Listen Slowly 👂")
                            .font(.title3.bold())
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(
                        Image("AppBackround")
                            .resizable()
                            .scaledToFill()
                    )
                    .foregroundColor(.white)
                    .cornerRadius(25)
                }
                .disabled(isSpeaking)
                .padding(.horizontal, 24)
                
                // Definition
                GlassCard {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack(spacing: 8) {
                            Image(systemName: "book.fill")
                                .foregroundStyle(.black)
                            Text("Definition")
                                .font(.headline)
                                .foregroundColor(.black)
                        }
                        
                        Text(definition)
                            .font(.body)
                            .foregroundColor(.black)
                            .lineSpacing(6)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                .padding(.horizontal, 24)
                
                Button(action: dismiss) {
                    Text("Got it! ✨")
                        .font(.headline.bold())
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(.ultraThinMaterial)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .stroke(AppTheme.teal.opacity(0.4), lineWidth: 1)
                        )
                        .cornerRadius(25)
                        .foregroundColor(.primary)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 16)
            }
            .padding(.top, 16)
        }
        .background(Color(.systemBackground))
        .onDisappear {
            stopSpeaking()
        }
    }
    
    private func speakWord() {
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playback, mode: .default)
            try audioSession.setActive(true)
        } catch {
            print("Failed to set audio session category: \(error)")
        }
        
        isSpeaking = true
        
        let utterance = AVSpeechUtterance(string: word)
        utterance.rate = 0.3
        utterance.pitchMultiplier = 1.2
        utterance.volume = 1.0
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        
        speechSynthesizer.stopSpeaking(at: .immediate)
        speechSynthesizer.speak(utterance)
        
        let wordLength = Double(word.count)
        let speakingTime = max(wordLength * 0.3, 1.5)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + speakingTime) {
            isSpeaking = false
        }
    }
    
    private func stopSpeaking() {
        speechSynthesizer.stopSpeaking(at: .immediate)
        isSpeaking = false
    }
    
    private func dismiss() {
        stopSpeaking()
        isPresented = false
    }
}

// Extension for easier presentation
extension View {
    func wordDetailSheet(word: String?, definition: String?, syllables: String?, isPresented: Binding<Bool>) -> some View {
        self.sheet(isPresented: isPresented) {
            Group {
                if #available(iOS 16.4, *) {
                    WordDetailView(
                        word: word ?? "",
                        definition: definition ?? "",
                        syllables: syllables,
                        isPresented: isPresented
                    )
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
                    .presentationCornerRadius(24)
                    .presentationBackground(Color(.systemBackground))
                } else {
                    WordDetailView(
                        word: word ?? "",
                        definition: definition ?? "",
                        syllables: syllables,
                        isPresented: isPresented
                    )
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
                    .background(Color(.systemBackground))
                }
            }
        }
    }
}

