

import Foundation

struct Quiz: Codable {
    let questions: [QuizQuestion]
}

struct QuizQuestion: Codable, Identifiable {
    let id: String
    let question: String
    let options: [String]
    let correctIndex: Int
}
