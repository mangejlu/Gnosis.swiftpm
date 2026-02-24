//
//  AppTheme.swift
//  Gnosis
//
//  Created by Mariangel J. Loaiza Urbina on 2/13/26.
//

import SwiftUI

struct AppTheme {

    static let primaryOrange = Color(red: 1.0, green: 0.55, blue: 0.30)
    static let sunshine = Color(red: 1.0, green: 0.75, blue: 0.20)
    static let teal = Color(red: 0.18, green: 0.70, blue: 0.65)
    static let secondaryText = Color.gray

    static let progressGradient = LinearGradient(
        colors: [primaryOrange, sunshine],
        startPoint: .leading,
        endPoint: .trailing
    )
    
    static let paperTop = Color(red: 1.0, green: 0.992, blue: 0.973)
    static let paperBottom = Color(red: 0.965, green: 0.937, blue: 0.890)
    static let paperGradient = LinearGradient(
        colors: [paperTop, paperBottom],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

