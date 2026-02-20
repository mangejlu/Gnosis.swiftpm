//
//  StoryReaderView.swift
//  Gnosis
//
//  Created by Mariangel J. Loaiza Urbina on 2/13/26.
//

import SwiftUI

struct StoryReaderView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var popToMap = false
    let chapter: Chapter
    @State private var showQuiz = false
    @State private var showBookCongrats = false
    @State private var isFinalChapter = false

    var body: some View {
        ZStack {
            BackgroundView()

            ScrollView {
                VStack(spacing: 20) {
                    Text(chapter.title)
                        .font(.title.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)

                    GlassCard {
                        VStack(alignment: .leading, spacing: 12) {
                            HighlightedTextView(
                                text: chapter.content,
                                highlights: chapter.highlightedWords
                            )
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(maxWidth: .infinity)

                    Button("Ready for the Quiz? 🎯") {
                        showQuiz = true
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(AppTheme.progressGradient)
                    .cornerRadius(25)
                    .foregroundColor(.white)
                }
                .padding()
            }
        }
        .navigationDestination(isPresented: $showQuiz) {
            QuizView(quiz: chapter.quiz, popToMap: $popToMap, onFinished: {
                if isFinalChapter {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        showBookCongrats = true
                    }
                }
            })
        }
        .fullScreenCover(isPresented: $showBookCongrats) {
            BookCompletionCongratsView(onClose: {
                showBookCongrats = false
                popToMap = true
                dismiss()
            })
        }
        .onChange(of: popToMap) { newValue in
            if newValue { dismiss() }
        }
        .onAppear {
            // Determine if this is the final chapter 
            if let book = LocalData.books.first(where: { $0.chapters.contains(where: { $0.id == chapter.id }) }),
               let idx = book.chapters.firstIndex(where: { $0.id == chapter.id }) {
                isFinalChapter = (idx == book.chapters.count - 1)
            } else {
                isFinalChapter = false
            }
        }
    }
}

