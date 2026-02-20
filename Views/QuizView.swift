//
//  QuizView.swift
//  Gnosis
//
//  Created by Mariangel J. Loaiza Urbina on 2/13/26.
//

import SwiftUI

struct QuizView: View {

    let quiz: Quiz
    @Binding var popToMap: Bool
    var onFinished: (() -> Void)? = nil

    @State private var current = 0
    @State private var score = 0
    @State private var selectedIndex: Int? = nil
    @State private var finished = false
    @State private var showConfetti = false
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            BackgroundView()

            if finished {
                VStack(spacing: 24) {
                    Text("Great job! 🎉")
                        .font(.largeTitle.bold())

                    Text("You scored \(score) / \(quiz.questions.count)")
                        .font(.title3)

                    if showConfetti {
                        ConfettiView()
                            .frame(height: 200)
                    }

                    Button("Done") {
                        popToMap = true
                        dismiss()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(AppTheme.progressGradient)
                    .cornerRadius(20)
                    .foregroundColor(.white)
                }
                .padding()
                .onAppear { showConfetti = true }
            } else {
                VStack(spacing: 24) {
                    // Progress
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Question \(current + 1) of \(quiz.questions.count)")
                            .font(.headline)
                        ProgressBarView(progress: Double(current) / Double(max(1, quiz.questions.count)))
                    }

                    Text("Quiz! 🎯")
                        .font(.largeTitle.bold())

                    Text(quiz.questions[current].question)
                        .font(.title3)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    VStack(spacing: 12) {
                        ForEach(0..<quiz.questions[current].options.count, id: \.self) { index in
                            let isCorrect = index == quiz.questions[current].correctIndex
                            let isSelected = selectedIndex == index

                            Button {
                                guard selectedIndex == nil else { return }
                                selectedIndex = index
                                if isCorrect { score += 1 }

                                // next
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                    if current < quiz.questions.count - 1 {
                                        current += 1
                                        selectedIndex = nil
                                    } else {
                                        finished = true
                                        onFinished?()
                                    }
                                }
                            } label: {
                                Text(quiz.questions[current].options[index])
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(buttonBackground(isSelected: isSelected, isCorrect: isCorrect))
                                    .foregroundColor(.primary)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(borderColor(isSelected: isSelected, isCorrect: isCorrect), lineWidth: isSelected ? 2 : 1)
                                    )
                                    .cornerRadius(20)
                            }
                            .disabled(selectedIndex != nil)
                        }
                    }

                    Text("Score: \(score)")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Spacer(minLength: 0)
                }
                .padding()
            }
        }
    }

    private func buttonBackground(isSelected: Bool, isCorrect: Bool) -> some View {
        Group {
            if selectedIndex != nil {
                if isCorrect {
                    Color.green.opacity(0.25)
                } else if isSelected {
                    Color.red.opacity(0.25)
                } else {
                    Color.white
                }
            } else {
                Color.white
            }
        }
    }

    private func borderColor(isSelected: Bool, isCorrect: Bool) -> Color {
        if selectedIndex != nil {
            return isCorrect ? .green : (isSelected ? .red : Color.gray.opacity(0.3))
        }
        return Color.gray.opacity(0.3)
    }
}

