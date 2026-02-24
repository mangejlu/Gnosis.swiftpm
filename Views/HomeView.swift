//
//  HomeView.swift
//  Gnosis
//
//  Created by Mariangel J. Loaiza Urbina on 2/13/26.
//

import SwiftUI

struct HomeView: View {

    @EnvironmentObject private var progressStore: ProgressStore
    @AppStorage("hasCompletedStartBook") private var hasCompletedStartBook: Bool = false
    @State private var showStartBook: Bool = false

    var body: some View {

        let books = LocalData.books
        let unlockedBooks = books.filter { !$0.isLocked }
        let firstUnlocked = unlockedBooks.first

        NavigationStack {

            ZStack {
                BackgroundView()

                ScrollView {

                    VStack(spacing: 24) {

                        // Streak Card
                        GlassCard {
                            HStack(alignment: .center, spacing: 14) {
                                Text("🔥")
                                    .font(.largeTitle)
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("7-Day Streak!")
                                        .font(.headline)
                                        .foregroundColor(.black)

                                    Text("You're on fire — keep it going!")
                                        .font(.subheadline)
                                        .foregroundColor(AppTheme.secondaryText)
                                }
                                Spacer()
                                Text("7️⃣")
                                    .font(.title2)
                            }
                            .frame(minHeight: 72)
                        }


                        TabView {

                            ForEach(LocalData.books) { book in

                                if book.isLocked {

                                    // Locked
                                    IslandCardView(book: book)
                                        .opacity(0.5)

                                } else {

                                    // Unlocked 
                                    NavigationLink {

                                        ChaptersMapView(book: book)

                                    } label: {

                                        IslandCardView(book: book)

                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                        .tabViewStyle(.page(indexDisplayMode: .automatic))
                        .frame(height: 380)


                        // Quick Start
                        
                        VStack(alignment: .leading, spacing: 16) {

                            Text("⚡ Quick Start")
                                .font(.title2.bold())
                                .foregroundColor(.black)


                            HStack(spacing: 16) {

                                
                                NavigationLink {
                                    if let book = firstUnlocked, let chapter = book.chapters.last {
                                        BossIntroView(chapter: chapter)
                                    } else {
                                        Text("No chapters available yet")
                                    }
                                } label: {
                                    GlassCard {
                                        VStack(alignment: .leading, spacing: 8) {
                                            Text("📚")
                                                .font(.largeTitle)
                                                .frame(maxWidth: .infinity, alignment: .leading)

                                            Text("Continue Reading")
                                                .font(.headline)
                                                .foregroundColor(.black)


                                            Text(firstUnlocked?.title ?? "Nothing to continue")
                                                .font(.subheadline)
                                                .foregroundColor(AppTheme.secondaryText)

                                            Text("Tip: Tap the island above to open chapters")
                                                .font(.caption)
                                                .foregroundColor(AppTheme.secondaryText)
                                        }
                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                    }
                                }
                                .buttonStyle(.plain)
                                .frame(maxWidth: .infinity)
                                .frame(height: 140)


                                // Daily Quiz
                                NavigationLink {

                                    if let quiz = firstUnlocked?.chapters.first?.quiz {
                                        QuizView(quiz: quiz, popToMap: .constant(false))
                                    } else {
                                        Text("No quiz available yet")
                                    }

                                } label: {

                                    GlassCard {
                                        VStack(alignment: .leading, spacing: 8) {
                                            Text("🎯")
                                                .font(.largeTitle)
                                                .frame(maxWidth: .infinity, alignment: .leading)

                                            Text("Daily Quiz")
                                                .font(.headline)
                                                .foregroundColor(.black)


                                            Text("\(firstUnlocked?.chapters.first?.quiz.questions.count ?? 0) questions ready")
                                                .font(.subheadline)
                                                .foregroundColor(AppTheme.secondaryText)
                                        }
                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                    }
                                }
                                .buttonStyle(.plain)
                                .frame(maxWidth: .infinity)
                                .frame(height: 140)
                            }
                            .padding(.horizontal, 2)
                        }

                    }
                    .padding(.horizontal)
                    .padding(.top)
                }
            }
        }
        .onAppear {
            if !hasCompletedStartBook {
                showStartBook = true
            }
        }
        .fullScreenCover(isPresented: $showStartBook) {
            StartBookView(onFinished: {
                hasCompletedStartBook = true
                showStartBook = false
            })
        }
    }
}

#Preview {
    HomeView().environmentObject(ProgressStore())
}

