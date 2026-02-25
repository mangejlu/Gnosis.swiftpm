
import SwiftUI

struct StoryReaderView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var progressStore: ProgressStore
    let chapter: Chapter
    @State private var currentBook: Book? = nil
    @State private var popToMap = false
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
                if let book = currentBook {
                    let total = book.chapters.count
                    // Compute this chapter's index
                    if let idx = book.chapters.firstIndex(where: { $0.id == chapter.id }) {
                        // If the user completed the current chapter (equal to progress), bump progress by 1
                        let currentProgress = progressStore.progress(for: book)
                        if idx == currentProgress && currentProgress < total {
                            progressStore.incrementProgress(for: book, totalChapters: total)
                        }
                    }
                }
                if isFinalChapter {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        showBookCongrats = true
                    }
                }
            })
            .environmentObject(progressStore)
        }
        .fullScreenCover(isPresented: $showBookCongrats) {
            BookCompletionView(onClose: {
                showBookCongrats = false
                popToMap = true
                dismiss()
            })
        }
        .onChange(of: popToMap) { newValue in
            if newValue { dismiss() }
        }
        .onAppear {
            if let book = LocalData.books.first(where: { $0.chapters.contains(where: { $0.id == chapter.id }) }),
               let idx = book.chapters.firstIndex(where: { $0.id == chapter.id }) {
                isFinalChapter = (idx == book.chapters.count - 1)
                currentBook = book
            } else {
                isFinalChapter = false
                currentBook = nil
            }
        }
    }
}

