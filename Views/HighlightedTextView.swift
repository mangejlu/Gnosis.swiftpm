//
//  HighlightedTextView.swift
//  Gnosis
//
//  Created by Mariangel J. Loaiza Urbina on 2/13/26.
//

import SwiftUI

struct HighlightedTextView: View {
    
    let text: String
    let highlights: [String: String]
    
    @State private var selectedWord: String?
    @State private var showAlert = false
    
    var body: some View {
        let attributedString = createAttributedString()
        
        return Text(attributedString)
            .font(.body)
            .foregroundStyle(.primary)
            .lineSpacing(6)
            .multilineTextAlignment(.leading)
            .fixedSize(horizontal: false, vertical: true)
            .environment(\.openURL, OpenURLAction { url in
                if url.scheme == "gnosis" {
                    let term = url.lastPathComponent.removingPercentEncoding ?? url.lastPathComponent
                    selectedWord = term
                    showAlert = true
                    return .handled
                }
                return .systemAction
            })
            .alert("New Word 🌟", isPresented: $showAlert) {
                Button("Got it!") { }
            } message: {
                Text(highlights[selectedWord ?? ""] ?? "")
            }
    }
    
    private func createAttributedString() -> AttributedString {
        var attributed = AttributedString(text)
        
        for (word, _) in highlights {
            var searchRange = text.startIndex..<text.endIndex
            
            while let range = text.range(of: word, options: .literal, range: searchRange) {
                if let lower = AttributedString.Index(range.lowerBound, within: attributed),
                   let upper = AttributedString.Index(range.upperBound, within: attributed) {
                    attributed[lower..<upper].foregroundColor = AppTheme.teal
                    attributed[lower..<upper].underlineStyle = .single
                    
                    if let encodedWord = word.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed),
                       let url = URL(string: "gnosis://word/\(encodedWord)") {
                        attributed[lower..<upper].link = url
                    }
                }
                searchRange = range.upperBound..<text.endIndex
            }
        }
        
        return attributed
    }
}

struct WrapChipsView: View {
    let words: [String]
    let onTap: (String) -> Void
    
    private let columns = [
        GridItem(.adaptive(minimum: 80), spacing: 8)
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, alignment: .leading, spacing: 8) {
            ForEach(words, id: \.self) { word in
                chip(for: word)
            }
        }
    }
    
    private func chip(for word: String) -> some View {
        Button(action: { onTap(word) }) {
            Text(word)
                .font(.subheadline)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(Capsule().fill(Color.white.opacity(0.8)))
                .overlay(
                    Capsule()
                        .stroke(AppTheme.teal.opacity(0.6), lineWidth: 1)
                )
        }
        .buttonStyle(.plain)
    }
}
