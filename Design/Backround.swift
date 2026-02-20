//
//  Backround.swift
//  Gnosis
//
//  Created by Mariangel J. Loaiza Urbina on 2/19/26.
//


import SwiftUI

struct BackgroundView: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.3), Color.pink.opacity(0.3)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ZStack {
                Circle()
                    .fill(Color.blue.opacity(0.25))
                    .frame(width: 220, height: 220)
                    .blur(radius: 40)
                    .offset(x: -140, y: -260)
                Circle()
                    .fill(Color.purple.opacity(0.25))
                    .frame(width: 260, height: 260)
                    .blur(radius: 50)
                    .offset(x: 160, y: -120)
                Circle()
                    .fill(Color.pink.opacity(0.25))
                    .frame(width: 280, height: 280)
                    .blur(radius: 55)
                    .offset(x: 120, y: 260)
            }
            .ignoresSafeArea()
        }
    }
}
