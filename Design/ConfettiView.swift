
import SwiftUI

struct ConfettiView: View {
    @State private var animate = false

    var body: some View {
        ZStack {
            ForEach(0..<15) { i in
                Circle()
                    .fill([Color.orange, Color.yellow, Color.pink, Color.blue].randomElement()!)
                    .frame(width: 8)
                    .offset(
                        x: animate ? CGFloat.random(in: -150...150) : 0,
                        y: animate ? CGFloat.random(in: -300...0) : 0
                    )
                    .opacity(animate ? 0 : 1)
                    .animation(.easeOut(duration: 1.2), value: animate)
            }
        }
        .onAppear { animate = true }
    }
}
